<?php
/**
 * @file
 * sample_content.features.inc
 */

/**
 * Implements hook_ctools_plugin_api().
 */
function sample_content_ctools_plugin_api() {
  list($module, $api) = func_get_args();
  if ($module == "boxes" && $api == "box") {
    return array("version" => "1");
  }
}
