<?php

/**
 * Implements hook_init().
 *
 * Adds javascript and css to make the menu scroll when too long
 */

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
 */
function system_form_install_select_profile_form_alter(&$form, $form_state) {
  foreach($form['profile'] as $key => $element) {
    $form['profile'][$key]['#value'] = 'openenterprise';
  }
}
