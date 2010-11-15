<?php
// $Id$
// 
// Define the default WYSIWYG editor
define('OPENENTERPRISE_EDITOR', 'ckeditor');

// Define the allowed filtered html tags
define('OPENENTERPRISE_FILTERED_HTML', '<a> <img> <br> <em> <p> <strong> <cite> <sub> <sup> <span> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd> <pre> <address> <h2> <h3> <h4> <h5> <h6>');

/**
 * Implementation of hook_profile_details().
 */
function openenterprise_profile_details() {
  return array(
    'name' => 'Open Enterprise',
    'description' => 'Open Enterprise by LevelTen.',
    'old_short_name' => 'enterprise_installer',
  );
}

/**
 * Implementation of hook_profile_modules().
 */
function openenterprise_profile_modules() {
  $modules = array(
     // Drupal core
    'color', 'comment', 'help', 'menu', 'taxonomy', 'dblog', 'profile',
    'blog', 'aggregator', 'poll',  'search', 'tracker', 'php', 'path',
    'contact',
    'taxonomy',
    // Admin
    'admin_menu',
    // Views
    'views', 'views_ui', 'views_slideshow', 'views_slideshow_singleframe',
    // CTools
    'ctools',
    // Context
    'context', 'context_ui', 'context_layouts',
    // Features
    'features',
    // Image
    'imageapi', 'imageapi_gd', 'imagecache',
    // Token
    'token', 
    // Editor
    'wysiwyg', 'better_formats',
    // Node Export
    'node_export', 'node_export_file',
    // Libraries
    'libraries',
    // Strongarm
    'strongarm',
    // Enable Google Analytics
    'googleanalytics',
    // Pathauto
    'path', 'pathauto',
    // Utilities
    'password_policy',
  );

  return $modules;
}

/**
 * Implementation of hook_profile_task_list().
 */
function openenterprise_profile_task_list() {
  $tasks['enterprise-nodes-batch'] = st('Import Example Nodes');
  return $tasks;
}

/**
 * Implementation of hook_profile_tasks().
 */
function openenterprise_profile_tasks(&$task, $url) {
  if ($task == 'profile') {
    // Set the default theme.
    openenterprise_config_filter();
    openenterprise_config_wysiwyg();
    openenterprise_config_password();
    variable_set('theme_default', 'oe');

    // Need a default for automated profile installs like with aegir.
    $features = variable_get('enabled_features', array(
      'enterprise' => 1,
      'enterprise_blog' => 1,
      'enterprise_calendar' => 1,
      'enterprise_faq' => 1,
      'enterprise_news' => 1,
      'enterprise_products' => 1,
      'enterprise_services' => 1,
      'enterprise_twitter' => 1,
      'enerprise_rotator' => 1,
    ));

    // Get features dependencies.
    $files = module_rebuild_cache();
    $dependencies = system_module_build_dependencies($files, array('status' => $features));
    foreach($dependencies as $feature => $module_list) {
      $modules[$feature] = $feature;
      foreach($module_list as $module) {
        $modules[$module] = $module;
      }
    }
    drupal_install_modules(array_keys($modules));

    $task = 'enterprise-nodes';
  }

  // We are running a batch task for this profile so basically do nothing and return page
  if (in_array($task, array('enterprise-nodes-batch'))) {
    include_once 'includes/batch.inc';
    $output = _batch_page();
  }

  if ($task == 'enterprise-nodes') {
    //do not use cached definition of node types, it will not include cck fields yet
    drupal_flush_all_caches();

    // For whatever reason the page pattern isn't set yet.  We need to set it here.
    variable_set("pathauto_node_page_pattern", "[title-raw]");

    if (variable_get('enterprise_demo_data', 1)) {
      foreach (array_filter($features) as $feature => $value) {
        $batch['operations'][] = array('_openenterprise_import_nodes_batch', array($feature));
      }
    }
    else { // Always install the enterprise feature nodes.
      $batch['operations'][] = array('_openenterprise_import_nodes_batch', array('enterprise'));
    }
    $batch['operations'][] = array('_openenterprise_setup_menus', array());
    $batch['finished'] = '_openenterprise_import_nodes_batch_finished';
    $batch['title'] = st('Importing Nodes @drupal', array('@drupal' => drupal_install_profile_name()));
    $batch['error_message'] = st('The installation has encountered an error.');

    // Start a batch, switch to 'intranet-modules-batch' task. We need to
    // set the variable here, because batch_process() redirects.
    variable_set('install_task', 'enterprise-nodes-batch');
    batch_set($batch);
    batch_process($url, $url);
    // Jut for cli installs. We'll never reach here on interactive installs.
    return;

  }

  return $output;
}

/**
 * Import process is finished, move on to the next step
 */
function _openenterprise_profile_batch_finished($success, $results) {
  variable_set('install_task', 'enterprise-nodes');
}

/**
 * 
 */
function _openenterprise_import_nodes_batch($feature, &$context) {
  include_once(drupal_get_path('module','node_export') . "/node_export.module");
  include_once(drupal_get_path('module','node_export_file') . "/node_export_file.module");
  $file = "profiles/openenterprise/nodes/"  . $feature . '.nodes.inc';
  if (file_exists($file)) {
    $node_code = file_get_contents($file);
    node_export_import(t($node_code, array('@site_name' => variable_get('site_name', 'Open Enterprise Site'))), NULL, FALSE, 'drupal_set_message', 'st');
    $context['message'] = st('Installed nodes');
  }
  return $node_nids;
}

/**
 * Finish function for import_nodes_batch.
 */
function _openenterprise_import_nodes_batch_finished() {
  variable_set('site_frontpage', 'home');
  // Clean up the variable.
  variable_del('enabled_features');
  variable_set('install_task', 'finished');
}

/**
 * Install menus
 */
function _openenterprise_menu_create_menu($name, $title, $description) {
  db_query("INSERT INTO {menu_custom} (menu_name, title, description) VALUES ('%s','%s', '%s')", $name, $title, $description);
  menu_rebuild(); // not sure if this is needed, but we've seen problems without it
}


/**
 * 
 */
function _openenterprise_setup_menus(&$context) {
  $menus = array(
    'footer-links' => array(
      'title' => 'Footer Links',
      'description' => 'Links that appear at the bottom of the site.'
    ),
  );
  foreach($menus AS $name => $config) {
    _openenterprise_menu_create_menu($name, $config['title'], $config['description']);
  }
  $nodes = db_query("SELECT * FROM {node}");
  while ($node = db_fetch_object($nodes)) {
    switch ($node->title) {
      case "About Us":
        $node_nids['about_us'] = $node->nid;
      break;
      case "Terms of Use":
        $node_nids['terms_of_use'] = $node->nid;
      break;
      case "Privacy Policy":
        $node_nids['privacy_policy'] = $node->nid;
      break;
    }
  }
  $item = new stdClass();
  $item = array('menu_name' => 'footer-links', 'link_path' => 'node/'. $node_nids['terms_of_use'], 'link_title' => st("Terms of Use"));
  menu_link_save($item);
  $item = array('menu_name' => 'footer-links', 'link_path' => 'node/'. $node_nids['privacy_policy'], 'link_title' => st("Privacy Policy"));
  menu_link_save($item);
  $item = array('menu_name' => 'footer-links', 'link_path' => 'node/'.$node_nids['about_us'], 'link_title' => st("About Us"));
  menu_link_save($item);
}


/**
 * Set Open Enterprise as default install profile.
 */
function system_form_install_select_profile_form_alter(&$form, $form_state) {
  foreach($form['profile'] as $key => $element) {
    $form['profile'][$key]['#value'] = 'openenterprise';
  }
}

/**
 * Alter the install profile configuration form and provide timezone location options.
 */
function system_form_install_configure_form_alter(&$form, $form_state) {
  $form['site_information']['#weight'] = -3;
  $form['site_information']['site_name']['#default_value'] = 'Open Enterprise Site';
  $form['site_information']['site_mail']['#default_value'] = 'admin@'. $_SERVER['HTTP_HOST'];
  $form['admin_account']['account']['name']['#default_value'] = 'admin';
  $form['admin_account']['account']['mail']['#default_value'] = 'admin@'. $_SERVER['HTTP_HOST'];

  if (function_exists('date_timezone_names') && function_exists('date_timezone_update_site')) {
    $form['server_settings']['date_default_timezone']['#access'] = FALSE;
    $form['server_settings']['#element_validate'] = array('date_timezone_update_site');
    $form['server_settings']['date_default_timezone_name'] = array(
      '#type' => 'select',
      '#title' => t('Default time zone'),
      '#default_value' => NULL,
      '#options' => date_timezone_names(FALSE, TRUE),
      '#description' => t('Select the default site time zone. If in doubt, choose the timezone that is closest to your location which has the same rules for daylight saving time.'),
      '#required' => TRUE,
    );
  }

  $features = features_get_features('', TRUE);
  $form['features'] = array(
    '#type' => 'fieldset',
    '#title' => 'Features',
    '#description' => 'Select which features you want to enable on your site.  You can enable more later by going to Administer->Site Building->Features',
    '#weight' => -2,
    '#tree' => TRUE,
  );
  foreach($features as $name => $module) {
    $ignore_modules = array('spaces_dashboard');
    if (!(strpos($name, '_test')) && !in_array($name, $ignore_modules)) {
      $form['features'][$name] = array(
        '#type' => 'checkbox',
        '#title' => $module->info['name'],
        '#description' => $module->info['description'],
        '#default_value' => TRUE,
        '#disabled' => $name == 'enterprise', // Require the enterprise module.
      );
    }
  }
  $form['enterprise'] = array(
    '#type' => 'fieldset',
    '#title' => 'Open Enterprise Settings',
    '#weight' => -1,
  );
  $form['enterprise']['enterprise_demo_data'] = array(
    '#type' => 'select',
    '#title' => 'Demo Data',
    '#description' => 'Import some demo data to quickly see a working site.',
    '#options' => array(
      '1' => 'Install Demo Data',
      '0' => 'Do Not Install Demo Data',
    ),
   );
  $form['#submit'][] = 'openenterprise_system_settings_form_submit';
}

function openenterprise_system_settings_form_submit($form, $form_state) {
  // Store off the selected features so we can enable them in the install step
  variable_set('enabled_features', $form_state['values']['features']);
  variable_set('enterprise_demo_data', $form_state['values']['enterprise_demo_data']);
}

/**
 * Configure input filters
 *
 * (From Drupal Commons)
 */
function openenterprise_config_filter() {
  // Force filter format and filter IDs
  // Necessary because Drupal doesn't use machine names for everything

  // Filtered HTML
  db_query("UPDATE {filters} f INNER JOIN {filter_formats} ff ON f.format = ff.format SET f.format = 1 WHERE ff.name = 'Filtered HTML'");
  db_query("UPDATE {filter_formats} SET format = 1 WHERE name = 'Filtered HTML'");

  // Full HTML
  db_query("UPDATE {filters} f INNER JOIN {filter_formats} ff ON f.format = ff.format SET f.format = 2 WHERE ff.name = 'Full HTML'");
  db_query("UPDATE {filter_formats} SET format = 2 WHERE name = 'Full HTML'");

  // PHP code
  db_query("UPDATE {filters} f INNER JOIN {filter_formats} ff ON f.format = ff.format SET f.format = 3 WHERE ff.name = 'PHP code'");
  db_query("UPDATE {filter_formats} SET format = 3 WHERE name = 'PHP code'");

  // Messaging
  db_query("UPDATE {filters} f INNER JOIN {filter_formats} ff ON f.format = ff.format SET f.format = 4 WHERE ff.name = 'Messaging plain text'");
  db_query("UPDATE {filter_formats} SET format = 4 WHERE name = 'Messaging plain text'");

  // Let community and content manager role use Full HTML
  db_query("UPDATE {filter_formats} SET roles = ',3,4,' WHERE name = 'Full HTML'");

  // Set Full HTML as default format for editor and writer roles
  db_query("INSERT INTO {better_formats_defaults} (rid, type, format, type_weight, weight)
    VALUES (3, 'node', 2, 1, -4)");
  db_query("INSERT INTO {better_formats_defaults} (rid, type, format, type_weight, weight)
    VALUES (3, 'comment', 2, 1, -4)");
  db_query("INSERT INTO {better_formats_defaults} (rid, type, format, type_weight, weight)
    VALUES (3, 'block', 2, 1, -4)");
  db_query("INSERT INTO {better_formats_defaults} (rid, type, format, type_weight, weight)
    VALUES (4, 'node', 2, 1, -6)");
  db_query("INSERT INTO {better_formats_defaults} (rid, type, format, type_weight, weight)
    VALUES (4, 'comment', 2, 1, -6)");
  db_query("INSERT INTO {better_formats_defaults} (rid, type, format, type_weight, weight)
    VALUES (4, 'block', 2, 1, -6)");

  // Add filters to the format
  db_query("INSERT INTO {filters} (format, module, delta, weight) VALUES (5, 'filter', 0, -10)");
  db_query("INSERT INTO {filters} (format, module, delta, weight) VALUES (5, 'filter', 2, -9)");

  // Adjust settings for the filter
  variable_set('filter_url_length_5', 60);
  variable_set('filter_html_5', 1);
  variable_set('filter_html_help_5', 0);
  variable_set('allowed_html_5', '');

  // Set allowed HTML tags for Filter HTML format
  variable_set('allowed_html_1', OPENENTERPRISE_FILTERED_HTML);

  // Add wiki-style freelinking to both default formats
  $sql = "INSERT INTO {filters} (format, module, delta, weight) VALUES (%d, '%s', %d, %d)";
  db_query($sql, 1, 'freelinking', 0, 10);  // Filtered HTML
  db_query($sql, 2, 'freelinking', 0, 10);  // Full HTML
}

/**
 * Configure wysiwyg
 *
 * (From Drupal Commons)
 */
function openenterprise_config_wysiwyg() {
  // Add settings for 'Filtered HTML'
  $item = new stdClass;
  $item->format = 1;
  $item->editor = OPENATRIUM_EDITOR;
  $item->settings = serialize(openenterprise_editor_settings('Filtered HTML'));
  drupal_write_record('wysiwyg', $item);

  // Add settings for 'Full HTML'
  $item = new stdClass;
  $item->format = 2;
  $item->editor = OPENATRIUM_EDITOR;
  $item->settings = serialize(openenterprise_editor_settings('Full HTML'));
  drupal_write_record('wysiwyg', $item);
}

/*
 *  Return settings for WYSIWYG editors
 *
 * @param $format
 *   The format name
 * @return
 *   An array of editor settings
 *
 * (From Drupal Commons)
 */
function openenterprise_editor_settings($format) {
  $settings = '';

  switch($format) {
    case 'Full HTML':
      $settings = array(
        'default' => 1,
        'user_choose' => 1,
        'show_toggle' => 1,
        'theme' => 'advanced',
        'language' => 'en',
        'buttons' => array(
          'default' => array(
            'Bold' => 1,
            'Italic' => 1,
            'Underline' => 1,
            'Strike' => 1,
            'JustifyLeft' => 1,
            'JustifyCenter' => 1,
            'JustifyRight' => 1,
            'JustifyBlock' => 1,
            'BulletedList' => 1,
            'NumberedList' => 1,
            'Outdent' => 1,
            'Indent' => 1,
            'Undo' => 1,
            'Redo' => 1,
            'Link' => 1,
            'Unlink' => 1,
            'Anchor' => 1,
            'Image' => 1,
            'Superscript' => 1,
            'Subscript' => 1,
            'Blockquote' => 1,
            'Cut' => 1,
            'Copy' => 1,
            'Paste' => 1,
            'RemoveFormat' => 1,
            'SpecialChar' => 1,
            'Format' => 1,
            'Table' => 1,
            'Find' => 1,
            'CreateDiv' => 1,
            'Maximize' => 1,
          ),
        ),
        'toolbar_loc' => 'top',
        'toolbar_align' => 'left',
        'path_loc' => 'bottom',
        'resizing' => 1,
        'verify_html' => 1,
        'preformatted' => 0,
        'convert_fonts_to_spans' => 0,
        'remove_linebreaks' => 0,
        'apply_source_formatting' => 0,
        'paste_auto_cleanup_on_paste' => 0,
        'block_formats' => 'p,address,pre,blockquote,h2,h3,h4,h5,h6,div',
        'css_setting' => 'theme',
        'css_path' => '',
        'css_classes' => '',
      );
      break;

    case 'Filtered HTML':
    default:
      $settings = array(
        'default' => 1,
        'user_choose' => 1,
        'show_toggle' => 1,
        'theme' => 'advanced',
        'language' => 'en',
        'buttons' => array(
          'default' => array(
            'Bold' => 1,
            'Italic' => 1,
            'Underline' => 1,
            'Strike' => 1,
            'JustifyLeft' => 1,
            'JustifyCenter' => 1,
            'JustifyRight' => 1,
            'JustifyBlock' => 1,
            'BulletedList' => 1,
            'NumberedList' => 1,
            'Outdent' => 1,
            'Indent' => 1,
            'Undo' => 1,
            'Redo' => 1,
            'Link' => 1,
            'Unlink' => 1,
            'Anchor' => 1,
            'Image' => 1,
            'Superscript' => 1,
            'Subscript' => 1,
            'Blockquote' => 1,
            'Cut' => 1,
            'Copy' => 1,
            'Paste' => 1,
            'PasteFromWord' => 1,
            'RemoveFormat' => 1,
            'Format' => 1,
            'SelectAll' => 1,
            'Find' => 1,
          ),
        ),
        'toolbar_loc' => 'top',
        'toolbar_align' => 'left',
        'path_loc' => 'bottom',
        'resizing' => 1,
        'verify_html' => 1,
        'preformatted' => 0,
        'convert_fonts_to_spans' => 1,
        'remove_linebreaks' => 0,
        'apply_source_formatting' => 0,
        'paste_auto_cleanup_on_paste' => 0,
        'block_formats' => 'p,address,pre,h2,h3,h4,h5,h6',
        'css_setting' => 'theme',
        'css_path' => '',
        'css_classes' => '',
      );
  }

  return $settings;
}

/**
 * Configure password policy
 *
 * (From Drupal Commons)
 */
function openenterprise_config_password() {
  // Create a password policy
  $policy = array(
    'alphanumeric' => 7,  // Contain at least 7 alphanumeric chars
    'username' => 1,      // Must not equal the username
    'length' => 7,        // Must be longer than 7 chars
    'punctuation' => 1,   // Punctuation is required
  );

  // Add the password policy
  db_query("INSERT INTO {password_policy} (pid, name, description, enabled, policy, created)
    VALUES (%d, '%s', '%s', %d, '%s', %d)",
    1,
    t('Constraints'),
    t('Default list of password constraints'),
    1,
    serialize($policy),
    time()
  );

  // Attach the policy to the authenticated user role
  db_query("INSERT INTO {password_policy_role} (rid, pid) VALUES (2, 1)");

  // Make the restrictions visible when changing your password
  variable_set('password_policy_show_restrictions', 1);
}
