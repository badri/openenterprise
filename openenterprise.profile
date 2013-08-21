<?php

/**
* A trick to enforce page refresh when theme is changed from an overlay.
*/
function openenterprise_admin_paths_alter(&$paths) {
  $paths['admin/appearance/default*'] = FALSE;
}

/**
 * Determine whether or not to skip the profile selection process. Normally when
 * downloading a distribution, there is only one additional profile to choose from
 * beside what core provides. We need to use the system hook, because openenterprise
 * is not yet active.
 */
if (!function_exists('system_form_install_select_profile_form_alter')) {
  function system_form_install_select_profile_form_alter(&$form, $form_state) {
    if (isset($_GET['profile']) && empty($_GET['profile'])) {
      foreach($form['profile'] as $key => $element) {
        $form['profile'][$key]['#value'] = 'openenterprise';
      }
      return;
    }
    $profiles = array_keys($form['profile']);
    if (in_array('OpenEnterprise', $profiles)) {
      foreach ($profiles as $key => $profile) {
        switch ($profile) {
          case 'Standard':
          case 'Minimal':
          case 'OpenEnterprise':
            unset($profiles[$key]);
            break;
        }
      }
      if (empty($profiles)) {
        install_goto('install.php?profile=openenterprise');
      }
    }
  }
}

/**
 * implements hook_install_configure_form_alter()
 */
function openenterprise_form_install_configure_form_alter(&$form, &$form_state) {
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

  $form['site_information']['site_name']['#default_value'] = 'OpenEnterprise';
  $form['site_information']['site_mail']['#default_value'] = 'admin@'. $_SERVER['HTTP_HOST'];
  $form['admin_account']['account']['name']['#default_value'] = 'admin';
  $form['admin_account']['account']['mail']['#default_value'] = 'admin@'. $_SERVER['HTTP_HOST'];
}

/**
 * Force-set a theme at any point during the execution of the request.
 *
 * Drupal doesn't give us the option to set the theme during the installation
 * process and forces enable the maintenance theme too early in the request
 * for us to modify it in a clean way.
 */
//function openenterprise_install_set_theme($target_theme) {
//  if ($GLOBALS['theme'] != $target_theme) {
//    unset($GLOBALS['theme']);
//    drupal_static_reset();
//    $GLOBALS['conf']['maintenance_theme'] = $target_theme;
//    _drupal_maintenance_theme();
//  }
//}

/**
 * Change the final task to our task
 */
//function openenterprise_install_tasks_alter(&$tasks, $install_state) {
//  openenterprise_install_set_theme('oe_install_theme');
//  $tasks['install_finished']['function'] = "openenterprise_install_finished";
//}

/**
 * Installation task; perform final steps and display a 'finished' page.
 *
 * @param $install_state
 *   An array of information about the current installation state.
 *
 * @return
 *   A message informing the user that the installation is complete.
 */
function openenterprise_install_finished(&$install_state) {
  drupal_set_title(st('@drupal installation complete', array('@drupal' => drupal_install_profile_distribution_name())), PASS_THROUGH);
  $link = '<front>';
  $output = '<h2>' . st('Congratulations, you installed @drupal!', array('@drupal' => drupal_install_profile_distribution_name())) . '</h2>';
  $output .= '<h2>' . st('Next Step') . '</h2>';
  $output .= '<p>' . st('<a href="@url">Go to your site\'s home page</a>.', array('@url' => url($link))) . '</p>';

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
function openenterprise_theme($existing, $type, $theme, $path) {
  return array(
    'openenterprise_logo' => array(
      'variables' => array(),
    ),
    'levelten_logo' => array(
      'variables' => array(),
    ),
  );
}

/**
 * Implements theme_openenterprise_logo().
 */
function theme_openenterprise_logo() {
  return '<img src="/profiles/openenterprise/openenterprise-logo-small.png" alt="" class="openenterprise" height="16" width="122" />';
}

/**
 * Implements theme_levelten_logo().
 */
function theme_levelten_logo() {
  return '<img src="/profiles/openenterprise/levelten-logo-small.png" alt="" class="levelten" height="16" width="52" />';
}

/**
 * Implements hook_block_info()
 */
function openenterprise_block_info() {
  $blocks['powered-by'] = array(
    'info' => t('Powered by OpenEnterprise'),
    'weight' => '10',
    'cache' => DRUPAL_NO_CACHE,
  );
  return $blocks;
}

/**
 * Implements hook_block_view().
 */
function openenterprise_block_view($delta = '') {
  switch ($delta) {
    case 'powered-by':
      $openenterprise = theme('openenterprise_logo');
      if (!$openenterprise) {
        $openenterprise = t('OpenEnterprise');
      }
      $levelten = theme('levelten_logo');
      if (!$levelten) {
        $levelten = t('LevelTen Interactive');
      }
      return array(
        'subject' => NULL,
        'content' => '<span>' . variable_get('site_name', t('This site')) . ' ' . t('is powered by <a href="http://drupal.org/project/openenterprise" title="OpenEnterprise" target="_blank">!openenterprise</a>. A distribution by <a href="http://www.leveltendesign.com" title="LevelTen Interactive" target="_blank">!levelten</a>.', array('!openenterprise' => $openenterprise, '!levelten' => $levelten)) . '</span>',
      );
  }
}
