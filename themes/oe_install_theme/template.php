<?php

/**
 * Hook_process_page().
 */
function oe_install_theme_preprocess_page(&$variables) {
  $theme_path = drupal_get_path('theme', 'oe_install_theme');
  drupal_add_css($theme_path . '/bootstrap/css/fontello.css', array('group' => CSS_THEME, 'preprocess' => FALSE));
  drupal_add_css($theme_path . '/bootstrap/css/fontello-ie7.css', array('group' => CSS_THEME, 'browsers' => array('IE' => 'IE 7', '!IE' => FALSE), 'preprocess' => FALSE));
  drupal_add_css($theme_path . '/bootstrap/css/animation.css', array('group' => CSS_THEME, 'preprocess' => FALSE));
}

/**
 * Hook_process_maintenance_page().
 */
function oe_install_theme_preprocess_maintenance_page(&$variables) {
  $theme_path = drupal_get_path('theme', 'oe_install_theme');
  drupal_add_css($theme_path . '/bootstrap/css/fontello.css');
  drupal_add_css($theme_path . '/bootstrap/css/fontello-ie7.css', array('group' => CSS_THEME, 'browsers' => array('IE' => 'IE 7', '!IE' => FALSE), 'preprocess' => FALSE));    
  drupal_add_css($theme_path . '/bootstrap/css/animation.css');
}

/**
 * Implements hook_js_alter().
 */
function oe_install_theme_js_alter(&$js) {
  unset($js['profiles/openenterprise/themes/bootstrap/bootstrap/js/bootstrap.js']);
  unset($js['profiles/openenterprise/themes/bootstrap/js/switch.js']);
  // Replace the progress bar JS.
  if (isset($js['misc/progress.js']) && !empty($js['misc/progress.js'])) {
    $js['misc/progress.js']['data'] = drupal_get_path('theme', 'oe_install_theme') . '/bootstrap/js/progress.js';
  }
  $js['//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js']['group'] = JS_LIBRARY;
  $js['//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js']['weight'] = -1000;
  $files = array(
    'misc/drupal.js',
    'misc/jquery.once.js',
  );
  foreach ($files as $file) {
    $js[$file] = drupal_js_defaults();
    $js[$file]['data'] = $file;
    $js[$file]['group'] = JS_LIBRARY;
    $js[$file]['weight'] = -100;
  }
}
  
/**
 * Returns HTML for status and/or error messages, grouped by type.
 *
 */
function oe_install_theme_status_messages($variables) {
  $display = $variables['display'];
  $output = '';
  $status_heading = array(
    'success' => t('Status message'),
    'error' => t('Error message'),
    'warning' => t('Warning message'),
  );
  foreach (drupal_get_messages($display) as $type => $messages) {
    if ($type == 'status') {
      $type = 'success';
    }
    $output .= "<div class=\"alert alert-block alert-$type\">\n";
    $output .= "  <a class=\"close\" data-dismiss=\"alert\" href=\"#\">x</a>\n";
    if (!empty($status_heading[$type])) {
      $output .= '<h4 class="alert-heading">' . $status_heading[$type] . "</h4>\n";
    }
    if (count($messages) > 1) {
      $output .= " <ul>\n";
      foreach ($messages as $message) {
        $output .= '  <li>' . $message . "</li>\n";
      }
      $output .= " </ul>\n";
    }
    else {
      $output .= $messages[0];
    }
    $output .= "</div>\n";
  }
  return $output;
}

function oe_install_theme_status_report($variables) {
  $requirements = $variables['requirements'];
  $severities = array(
    REQUIREMENT_INFO => array(
      'title' => t('Info'),
      'class' => 'info',
      'icon' => 'info',
    ),
    REQUIREMENT_OK => array(
      'title' => t('OK'),
      'class' => 'success',
      'icon' => 'check',
    ),
    REQUIREMENT_WARNING => array(
      'title' => t('Warning'),
      'class' => 'warning',
      'icon' => 'warning',
    ),
    REQUIREMENT_ERROR => array(
      'title' => t('Error'),
      'class' => 'error',
      'icon' => 'cancel',
    ),
  );
  $output = '<table class="system-status-report table table-hover table-condensed table-striped">';
  foreach ($requirements as $requirement) {
    if (empty($requirement['#type'])) {
      $severity = $severities[isset($requirement['severity']) ? (int) $requirement['severity'] : 0];
      $severity['icon'] = '<i class="icon icon-' . $severity['icon'] . '"></i><span class="element-invisible">' . $severity['title'] . '</span>';

      // Output table row(s)
      if (!empty($requirement['description'])) {
        $output .= '<tr class="' . $severity['class'] . ' merge-down"><td class="status-icon">' . $severity['icon'] . '</td><td class="status-title">' . $requirement['title'] . '</td><td class="status-value">' . $requirement['value'] . '</td></tr>';
        $output .= '<tr class="' . $severity['class'] . ' merge-up"><td colspan="3" class="status-description">' . $requirement['description'] . '</td></tr>';
      }
      else {
        $output .= '<tr class="' . $severity['class'] . '"><td class="status-icon">' . $severity['icon'] . '</td><td class="status-title">' . $requirement['title'] . '</td><td class="status-value">' . $requirement['value'] . '</td></tr>';
      }
    }
  }

  $output .= '</table>';
  return $output;
}

function oe_install_theme_task_list($variables) {
  $items = $variables['items'];
    
  $data = array(
    'install_select_profile' => array(
      'title' => 'Profile',
      'link' => '/install.php?profile=',
      'icon' => 'drupal',
    ),
    'install_select_locale' => array(
      'title' => 'Language',
      'icon' => 'language',
    ),
    'install_verify_requirements' => array(
      'title' => 'Requirements',
      'icon' => 'list-alt',
    ),
    'install_settings_form' => array(
      'title' => 'Database',
      'icon' => 'database',
    ),
    'install_profile_modules' => array(
      'title' => 'Install',
      'icon' => 'install',
    ),
    'install_configure_form' => array(
      'title' => 'Configure',
      'icon' => 'cogs',
    ),
    'apps_install_verify' => array(
      'title' => 'Verify Apps',
      'icon' => 'download-cloud',
    ),
    'apps_profile_apps_select_form_levelten' => array(
      'title' => 'Install Apps',
      'icon' => 'install',
    ),
    'install_finished' => array(
      'title' => 'Finished',
      'icon' => 'flag',
    ),
  );
  $active = $variables['active'];

  $done = isset($items[$active]) || $active == NULL;
  $output = '<h2 class="element-invisible">Installation tasks</h2>';
  $output .= '<ul class="inline task-list">';

  foreach ($items as $k => $item) {
    if (isset($data[$k]) && !empty($data[$k])) {
      $item = $data[$k];
    }
    if ($active == $k) {
      $class = 'active';
      $status = '(' . t('active') . ')';
      $done = FALSE;
    }
    else {
      $class = $done ? 'done' : '';
      $status = $done ? '(' . t('done') . ')' : '';
    }
    $output .= '<li';
    $output .= ($class ? ' class="' . $class . '"' : '') . '>';
    if (is_array($item)) {
      $title = '<span class="icons">';
      if ($done) {
        $title .= '<i class="icon-check"></i>';
      }
      if (isset($item['icon']) && !empty($item['icon'])) {
        $title .= '<i class="icon-' . $item['icon'] . '"></i>';
      }
      $title .= '</span>';
      $title .= '<label>' . $item['title'] . '</label>';
      if ($done && isset($item['link']) && !empty($item['link'])) {
        $title = l($title, $item['link'], array('html' => TRUE, 'external' => TRUE, 'attributes' => array('class' => 'task-label')));
      }
      else {
        $title = '<span class="task-label">' . $title . '</span>';
      }
      $output .= $title;
    }
    else {
      $output .= '<span class="task-label"><label>' . $item . '</label></span>';
    }
    $keys = array_keys($items);
    if ($k !== array_pop($keys)) {
      $output .= '<i class="icon-right-open-big separator"></i>';
    }
    $output .= ($status ? '<span class="element-invisible">' . $status . '</span>' : '');
    $output .= '</li>';
  }
  $output .= '</ul>';
  return $output;
}

function oe_install_theme_progress_bar($variables) {
  $output .= '<div id="progress" class="progress-wrapper">';
  $output .= '  <div class="progress progress-striped active">';
  $output .= '    <div class="bar" style="width: ' . $variables['percent'] . '%"></div>';
  $output .= '  </div>';
  $output .= '  <div class="percentage">' . $variables['percent'] . '%</div>';
  $output .= '  <div class="message">' . $variables['message'] . '</div>';
  $output .= '</div>';

  return $output;
}