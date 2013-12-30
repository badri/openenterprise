<?php

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
 * Determine whether or not to skip the local selection process. By default
 * there is only one language which adds a step in the installer. We'll assume
 * that anyone who knows about localization is smart enough to add the language.
 */
if (!function_exists('system_form_install_select_locale_form_alter')) {
  function system_form_install_select_locale_form_alter(&$form, $form_state) {
    if (!isset($_GET['locale'])) {
      // If there is only one language, select it automatically.
      if (count(element_children($form['locale'])) == 1) {
        install_goto('install.php?profile=' . $_GET['profile'] . '&locale=en');
      } 
    }  
  }
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
