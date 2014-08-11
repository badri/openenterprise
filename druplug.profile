<?php

/**
* A trick to enforce page refresh when theme is changed from an overlay.
*/
function druplug_admin_paths_alter(&$paths) {
  $paths['admin/appearance/default*'] = FALSE;
}

/**
 * Set Druplug as default install profile.
 *
 * Must use system as the hook module because druplug is not active yet
 */
function system_form_install_select_profile_form_alter(&$form, $form_state) {
  foreach($form['profile'] as $key => $element) {
    $form['profile'][$key]['#value'] = 'druplug';
  }
}
/**
 * Implements hook_appstore_stores_info
 */
function druplug_apps_servers_info() {
  $profile = variable_get('install_profile', 'standard');
  $info =  drupal_parse_info_file(drupal_get_path('profile', $profile) . '/' . $profile . '.info');
  return array(
    'druplug' => array(
      'title' => 'Druplug',
      'description' => "Apps provided by Druplug",
      'manifest' => 'http://apps.druplug.com/app/query',
      'profile' => $profile,
      'profile_version' => isset($info['version']) ? $info['version'] : '7.x-1.x',
      'server_name' => $_SERVER['SERVER_NAME'],
      'server_ip' => $_SERVER['SERVER_ADDR'],
    ),
  );
}

/**
 * implements hook_install_configure_form_alter()
 */
function druplug_form_install_configure_form_alter(&$form, &$form_state) {
  // Many modules set messages during installation that are very annoying.
  // (I'm looking at you Date and IMCE)
  // Lets remove these and readd the only message that should be set.
  drupal_get_messages('status');
  drupal_get_messages('warning');

  // Warn about settings.php permissions risk
  $settings_dir = conf_path();
  $settings_file = $settings_dir . '/settings.php';
  // Check that $_POST is empty so we only show this message when the form is
  // first displayed, not on the next page after it is submitted. (We do not
  // want to repeat it multiple times because it is a general warning that is
  // not related to the rest of the installation process; it would also be
  // especially out of place on the last page of the installer, where it would
  // distract from the message that the Drupal installation has completed
  // successfully.)
  if (empty($_POST) && (!drupal_verify_install_file(DRUPAL_ROOT . '/' . $settings_file, FILE_EXIST|FILE_READABLE|FILE_NOT_WRITABLE) || !drupal_verify_install_file(DRUPAL_ROOT . '/' . $settings_dir, FILE_NOT_WRITABLE, 'dir'))) {
    drupal_set_message(st('All necessary changes to %dir and %file have been made, so you should remove write permissions to them now in order to avoid security risks. If you are unsure how to do so, consult the <a href="@handbook_url">online handbook</a>.', array('%dir' => $settings_dir, '%file' => $settings_file, '@handbook_url' => 'http://drupal.org/server-permissions')), 'warning');
  }

  $form['site_information']['site_name']['#default_value'] = 'Druplug';
  $form['site_information']['site_mail']['#default_value'] = 'admin@'. $_SERVER['HTTP_HOST'];
  $form['admin_account']['account']['name']['#default_value'] = 'admin';
  $form['admin_account']['account']['mail']['#default_value'] = 'admin@'. $_SERVER['HTTP_HOST'];
}

/**
 * Implements hook_install_tasks
 */
function druplug_install_tasks($install_state) {
  $tasks = array();
  require_once(drupal_get_path('module', 'apps') . '/apps.profile.inc');
  $server = array(
    'machine name' => 'druplug',
    'default apps' => array(
      'enterprise_rotator',
      'enterprise_blog',
    ),
    'required apps' => array(

    ),
    'default content callback' => 'druplug_default_content',
  );
  $tasks = $tasks + apps_profile_install_tasks($install_state, $server);
  return $tasks;
}

/**
 * Apps installer default content callback.
 */
function druplug_default_content(&$modules) {
  $modules[] = 'sample_content';
  $files = system_rebuild_module_data();
  foreach($modules as $module) {
    // Should probably check the app to see the proper way to do this.
    if (isset($files[$module . '_content'])) {
      $modules[] = $module . '_content';
    }
  }
}

/**
 * Modify the apps_select_form
 *
 * Add a custom callback so we can save the apps selection for later.
 */
function druplug_form_apps_profile_apps_select_form_alter(&$form, $form_state) {
  // panopoly_form_apps_profile_apps_select_form_alter($form, $form_state);
  ############## INCLUDE FROM PANOPOLY #####################
    // For some things there are no need
  $form['apps_message']['#access'] = FALSE;
  $form['apps_fieldset']['apps']['#title'] = NULL;

  // Improve style of apps selection form
  if (isset($form['apps_fieldset'])) {
    $manifest = apps_manifest(apps_servers('panopoly'));
    foreach ($manifest['apps'] as $name => $app) {
      if ($name != '#theme') {
        $form['apps_fieldset']['apps']['#options'][$name] = '<strong>' . $app['name'] . '</strong><p><div class="admin-options"><div class="form-item">' . theme('image', array('path' => $app['logo']['path'], 'height' => '32', 'width' => '32')) . '</div>' . $app['description'] . '</div></p>';
      }
    }
  }

  // Remove the demo content selection option since this is handled through the Panopoly demo module.
  $form['default_content_fieldset']['#access'] = FALSE;
  // ########### END PANOPOLY ################

  $form['#submit'][] = 'druplug_apps_profile_apps_select_form_submit';
}

/**
 * Submit callback for apps_profile_apps_select_form
 */
function druplug_apps_profile_apps_select_form_submit($form, $form_state) {
  if ($form_state['values']['op'] == t('Install Apps') && isset($form_state['values']['apps']) && !empty($form_state['values']['apps'])) {
    $apps = array_filter($form_state['values']['apps']);
    $_SESSION['druplug_apps_installed'] = FALSE;
    if (!empty($apps)) {
      $_SESSION['druplug_apps_installed'] = TRUE;
    }
    $_SESSION['druplug_apps_default_content'] = $form_state['values']['default_content'];
  }
}

/**
 * Change the final task to our task
 */
function druplug_install_tasks_alter(&$tasks, $install_state) {
  // Magically go one level deeper in solving years of dependency problems
  require_once(drupal_get_path('module', 'panopoly_core') . '/panopoly_core.profile.inc');
  $tasks['install_load_profile']['function'] = 'panopoly_core_install_load_profile';
  $tasks['install_finished']['function'] = "druplug_install_finished";
}

/**
 * Installation task; perform final steps and display a 'finished' page.
 *
 * @param $install_state
 *   An array of information about the current installation state.
 *
 * @return
 *   A message informing the user that the installation is complete.
 */
function druplug_install_finished(&$install_state) {
  drupal_set_title(st('@drupal installation complete', array('@drupal' => drupal_install_profile_distribution_name())), PASS_THROUGH);
  if (!isset($_SESSION['druplug_apps_installed']) || !$_SESSION['druplug_apps_installed']) {
    $output = '<h2>' . st('Congratulations, you installed @drupal!', array('@drupal' => drupal_install_profile_distribution_name())) . '</h2>';
    $output .= '<p>' . st('By not installing any apps, your site is currently a blank. To get started you can either create your own content types, views and set up the site yourself or install some prebuild apps. Apps provide complete bundled functionality that will greatly speed up the process of creating your site.') . '</p>';
    $output .= '<p>' . st('Even after installing apps your site may look very empty before you add some content. To see what it looks like with content, try installing the default content for each of the apps. This can be done on each app\'s configuration page.') . '</p>';
    $output .= '<h2>' . st('Next Step') . '</h2>';
    $output .= '<p>' . st('<a href="@url">Install some apps</a>', array('@url' => url('admin/apps'))) . ' or ' . st('<a href="@url">go to your site\'s home page</a>.', array('@url' => url('<front>'))) . '</p>';
  }
  else {
    $link = (isset($_SESSION['druplug_apps_default_content']))?drupal_get_normal_path('home'):'<front>';
    $output = '<h2>' . st('Congratulations, you installed @drupal!', array('@drupal' => drupal_install_profile_distribution_name())) . '</h2>';
    $output .= '<p>' . st('Your site now contains the apps you selected. To add more, go to the Apps menu in the admin menu at the top of the site.') . '</p>';
    $output .= '<h2>' . st('Next Step') . '</h2>';
    $output .= '<p>' . st('<a href="@url">Go to your site\'s home page</a>.', array('@url' => url($link))) . '</p>';
  }

  // Flush all caches to ensure that any full bootstraps during the installer
  // do not leave stale cached data, and that any content types or other items
  // registered by the install profile are registered correctly.
  drupal_flush_all_caches();

  // Remember the profile which was used.
  variable_set('install_profile', drupal_get_profile());

  // Install profiles are always loaded last
  db_update('system')
    ->fields(array('weight' => 1000))
    ->condition('type', 'module')
    ->condition('name', drupal_get_profile())
    ->execute();

  $theme_default = 'kappa';
  $admin_theme = 'rubik';
  theme_enable(array('omega', $theme_default, 'tao', $admin_theme));

  // Cache a fully-built schema.
  drupal_get_schema(NULL, TRUE);

  // Run cron to populate update status tables (if available) so that users
  // will be warned if they've installed an out of date Drupal version.
  // Will also trigger indexing of profile-supplied content or feeds.
  drupal_cron_run();

  return $output;
}


/**
 * Implements hook_theme().
 */
function druplug_theme($existing, $type, $theme, $path) {
  return array(
    'druplug_logo' => array(
      'variables' => array(),
    ),
  );
}

/**
 * Implements theme_druplug_logo().
 */
function theme_druplug_logo() {
  return '<img src="/profiles/druplug/druplug-logo-small.png" alt="" class="druplug" height="16" width="122" />';
}

/**
 * Implements hook_block_info()
 */
function druplug_block_info() {
  $blocks['powered-by'] = array(
    'info' => t('Powered by Druplug'),
    'weight' => '10',
    'cache' => DRUPAL_NO_CACHE,
  );
  return $blocks;
}

/**
 * Implements hook_block_view().
 */
function druplug_block_view($delta = '') {
  switch ($delta) {
    case 'powered-by':
      $druplug = theme('druplug_logo');
      if (!$druplug) {
        $druplug = t('Druplug');
      }
      return array(
        'subject' => NULL,
        'content' => '<span>' . variable_get('site_name', t('This site')) . ' ' . t('is powered by <a href="http://drupal.org/project/druplug" title="Druplug" target="_blank">!druplug</a>.', array('!druplug' => $druplug)) . '</span>',
      );
  }
}

/**
 * Implements hook_init()
 *
 * Add a message if this is the druplug apps page.
 */
function druplug_init() {
  if ($_GET['q'] == 'admin/apps/druplug') {
    apps_include('manifest');
    $server = apps_servers('druplug');
    // Create args array for substitutions
    $manifest = apps_manifest($server);
    if (isset($manifest['message']) && $manifest['message'] != '') {
      foreach($server as $key => $value) {
        $args['!' . $key] = $value;
      }
      drupal_set_message(format_string($manifest['message'], $args));
    }
  }
}
