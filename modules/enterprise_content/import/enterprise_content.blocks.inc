<?php

/**
 * @file
 * Migrations for blocks.
 */

class OpenEnterpriseBlocks extends Migration {
  public function __construct() {
    parent::__construct();
    $this->description = t('Basic text blocks for Open Enterprise using fieldable panels panes');
    $this->map = new MigrateSQLMap($this->machineName,
      array(
      'vid' => array(
        'type' => 'int',
        'unsigned' => TRUE,
        'not null' => TRUE,
        ),
      ),
      MigrateDestinationFieldablePanelsPanes::getKeySchema()
    );
    // Create MigrateSource object
    $import_path = drupal_get_path('module', 'enterprise_content') . '/import/data/';

    // Create a MigrateSource object.
    $this->source = new MigrateSourceCSV($import_path . 'enterprise_content.blocks.csv', $this->csvcolumns(), array('header_rows' => 1));

    // Create destination
    $this->destination = new MigrateDestinationFieldablePanelsPanes('text');
    $this->addFieldMapping('title', 'title');
    $this->addFieldMapping('bundle', 'text');
    $this->addFieldMapping('link', 'title_has_link')->defaultValue(FALSE);
    $this->addFieldMapping('path', 'title_link_path')->defaultValue('');
    $this->addFieldMapping('reusable')->defaultValue(TRUE);
    $this->addFieldMapping('language')->defaultValue(LANGUAGE_NONE);
    $this->addFieldMapping('field_basic_text_text', 'content');
    $this->addFieldMapping('field_basic_text_text:format')->defaultValue('panopoly_wysiwyg_text');
    $this->addFieldMapping('category', 'category');
    $this->addUnmigratedDestinations(array(
      'vid',
      'field_basic_text_text:language',
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
    $columns[0] = array('title', 'Title');
    $columns[1] = array('title_has_link', 'TitleHasLink');
    $columns[2] = array('title_link_path', 'TitleLinkPath');
    $columns[3] = array('content', 'Content');
    $columns[4] = array('category', 'Category');
    return $columns;
  }
}
