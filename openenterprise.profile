<?php
// $Id: openenterprise.profile,v 1.15 2010/08/11 04:02:58 yhahn Exp $

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
    'block',
    'comment',
    'filter',
    'help',
    'menu',
    'node',
    'search',
    'system',
    'taxonomy',
    'upload',
    'user',
    // Admin
    'admin',
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
    variable_set('theme_default', 'danblog');

    // Need a default for automated profile installs like with aegir.
    $features = variable_get('enabled_features', array(
      'enterprise' => 1,
      'enterprise_blog' => 1,
      'enterprise_calendar' => 1,
      'enterprise_faq' => 1,
      'enterprise_news' => 1,
      'enterprise_offerings' => 1,
      'enterprise_twitter' => 1,
      'rotator' => 1,
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

