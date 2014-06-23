<?php

/**
 * @file
 * Migrations for blocks with image.
 */

class OpenEnterpriseImageBlocks extends Migration {
  public function __construct() {
    parent::__construct();
    $this->description = t('Image blocks for Open Enterprise using fieldable panels panes');
    $this->map = new MigrateSQLMap($this->machineName,
      array(
      'fppid' => array(
        'type' => 'int',
        'unsigned' => TRUE,
        'not null' => TRUE,
        'description' => 'FPP id'
      ),
      ),
      MigrateDestinationFieldablePanelsPanes::getKeySchema()
    );
    // Create MigrateSource object
    $import_path = drupal_get_path('module', 'enterprise_content') . '/import/data/';

    // Create a MigrateSource object.
    $this->source = new MigrateSourceCSV($import_path . 'enterprise_content.image_blocks.csv', $this->csvcolumns(), array('header_rows' => 1));

    // Create destination
    $this->destination = new MigrateDestinationFieldablePanelsPanes('image');
    $this->addFieldMapping('title', 'title');
    $this->addFieldMapping('bundle', 'text');
    $this->addFieldMapping('link', 'title_has_link')->defaultValue(FALSE);
    $this->addFieldMapping('path', 'title_link_path')->defaultValue('');
    $this->addFieldMapping('reusable')->defaultValue(TRUE);
    $this->addFieldMapping('language')->defaultValue(LANGUAGE_NONE);
    $this->addFieldMapping('field_basic_image_image', 'image');
    $this->addFieldMapping('field_basic_image_image:file_replace')
      ->defaultValue(FILE_EXISTS_REPLACE);
    $this->addFieldMapping('field_basic_image_image:source_dir')
      ->defaultValue(drupal_get_path('module', 'enterprise_content') . '/import/data/images');

    $this->addFieldMapping('field_basic_image_caption', 'caption');
    $this->addFieldMapping('field_basic_image_caption:format')->defaultValue('panopoly_wysiwyg_text');
    $this->addFieldMapping('category', 'category');
    $this->addUnmigratedDestinations(array(
      'vid',
      'field_basic_image_caption:summary',
      'field_basic_image_caption:language',
      'admin_title',
      'admin_description',
      'language'
    ));
  }
  /**
   * Source columns array
   * @return mixed
   */
  function csvcolumns() {
    $columns[0] = array('fppid', 'Id');
    $columns[1] = array('title', 'Title');
    $columns[2] = array('title_has_link', 'TitleHasLink');
    $columns[3] = array('title_link_path', 'TitleLinkPath');
    $columns[4] = array('image', 'Image');
    $columns[5] = array('caption', 'Caption');
    return $columns;
  }
}
