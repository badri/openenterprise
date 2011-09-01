<?php

/**
 * Implements hook_requirements
 *
 * Make sure that the sites directory is writable.
 */
function apps_requirements($phase) {
  if ($phase == 'install') {
    $requirements['sites all dir']['title'] = 'sites/all Directory';
    if (is_writable('sites/all')) {
      $requirements['sites all dir']['severity'] = REQUIREMENT_OK;
      $requirements['sites all dir']['value'] = 'Writable';
    }
    else {
      $requirements['sites all dir']['severity'] = REQUIREMENT_ERROR;
      $requirements['sites all dir']['value'] = 'Not Writable';
      $requirements['sites all dir']['description'] = 'In order to use apps the sites/all directory must be writable.';
    }
    $requirements['sites default dir']['title'] = 'sites/default Directory';
    if (is_writable('sites/default')) {
      $requirements['sites default dir']['severity'] = REQUIREMENT_OK;
      $requirements['sites default dir']['value'] = 'Writable';
    }
    else {
      $requirements['sites default dir']['severity'] = REQUIREMENT_ERROR;
      $requirements['sites default dir']['value'] = 'Not Writable';
      $requirements['sites default dir']['description'] = 'In order to use apps the sites/default directory must be writable.';
    }
  }
  return $requirements;
}

/**
 * Implements hook_form_alter().
 *
 * Allows the profile to alter the site-configuration form. This is
 * called through custom invocation, so $form_state is not populated.
 */
function openenterprise_form_alter(&$form, $form_state, $form_id) {
  if ($form_id == 'install_configure_form') {
    $roles = array(DRUPAL_AUTHENTICATED_RID);
    $policy = _password_policy_load_active_policy($roles);

    $translate = array();
    if (!empty($policy['policy'])) {
      // Some policy constraints are active.
      password_policy_add_policy_js($policy, 1);
      foreach ($policy['policy'] as $key => $value) {
        $translate['constraint_'. $key] = _password_policy_constraint_error($key, $value);
      }
    }

    // Set a custom form validate and submit handlers.
    $form['#validate'][] = 'openenterprise_password_validate';
    $form['#submit'][] = 'openenterprise_password_submit';
  }
}


/**
* A trick to enforce page refresh when theme is changed from an overlay.
*/
function openenterprise_admin_paths_alter(&$paths) {
  $paths['admin/appearance/default*'] = FALSE;
}


/**
 * Password save validate handler.
 */
function openenterprise_password_validate($form, &$form_state) {
  $values = $form_state['values'];
  $account = (object)array('uid' => 1);
  $account->roles = array(DRUPAL_AUTHENTICATED_RID => DRUPAL_AUTHENTICATED_RID);

  if (!empty($values['account']['pass'])) {
    $error = _password_policy_constraint_validate($values['account']['pass'], $account);
    if ($error) {
      form_set_error('pass', t('Your password has not met the following requirement(s):') .'<ul><li>'. implode('</li><li>', $error) .'</li></ul>');
    }
  }
}

/**
 * Password save submit handler.
 */
function openenterprise_password_submit($form, &$form_state) {
  global $user;

  $values = $form_state['values'];
  $account = (object)array('uid' => 1);

  // Track the hashed password values which can then be used in the history constraint.
  if ($account->uid && !empty($values['account']['pass'])) {
    _password_policy_store_password($account->uid, $values['account']['pass']);
  }
}

/**
 * Implements hook_appstore_stores_info
 */
function openenterprise_apps_servers_info() {
  $profile = variable_get('install_profile', 'standard');
  $info =  drupal_parse_info_file(drupal_get_path('profile', $profile) . '/' . $profile . '.info');
  return array(
    'levelten' => array(
      'title' => 'LevelTen',
      'description' => "Apps from LevelTen Interactive",
      'manifest' => 'http://apps.leveltendesign.com/app/query',
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
function openenterprise_form_install_configure_form_alter(&$form, &$form_state) {
  $form['site_information']['site_name']['#default_value'] = 'OpenEnterprise';
  $form['site_information']['site_mail']['#default_value'] = 'admin@'. $_SERVER['HTTP_HOST'];
  $form['admin_account']['account']['name']['#default_value'] = 'admin';
  $form['admin_account']['account']['mail']['#default_value'] = 'admin@'. $_SERVER['HTTP_HOST'];
}

/**
 * Set Open Enterprise as default install profile.
 *
 * Must use system as the hook module because openenterprise is not active yet
 */
function system_form_install_select_profile_form_alter(&$form, $form_state) {
  // Hide default drupal profiles
  unset($form['profile']['Minimal']);
  unset($form['profile']['Standard']);
  foreach($form['profile'] as $key => $element) {
    $form['profile'][$key]['#value'] = 'openenterprise';
  }
}

/**
 * Change the final task to our task
 */
function openenterprise_install_tasks_alter(&$tasks, $install_state) {
  $tasks['install_finished']['function'] = "openenterprise_install_finished";
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
function openenterprise_install_finished(&$install_state) {
  drupal_set_title(st('@drupal installation complete', array('@drupal' => drupal_install_profile_distribution_name())), PASS_THROUGH);
  $messages = drupal_set_message();
  $output = '<p>' . st('Congratulations, you installed @drupal!', array('@drupal' => drupal_install_profile_distribution_name())) . '</p>';
  $output .= '<p>' . (isset($messages['error']) ? st('Review the messages above before installing <a href="@url">some apps</a>.', array('@url' => url('admin/apps'))) : st('<a href="@url">Now install some apps</a>.', array('@url' => url('admin/apps')))) . '</p>';

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
