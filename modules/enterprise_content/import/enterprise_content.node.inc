<?php

/**
 * @file
 * Migrations for Basic Nodes.
 */

class OpenEnterpriseNode extends Migration {

  public function __construct($arguments = array()) {
    parent::__construct($arguments = array());
    $this->description = t('Import nodes.');

    // Create a map object for tracking the relationships between source rows.
    $this->map = new MigrateSQLMap($this->machineName,
      array(
        'title' => array(
          'type' => 'varchar',
          'length' => 255,
          'not null' => TRUE,
        ),
      ),
      MigrateDestinationNode::getKeySchema()
    );

    $import_path = drupal_get_path('module', 'enterprise_content') . '/import/data/';

    // Create a MigrateSource object.
    $this->source = new MigrateSourceCSV($import_path . 'enterprise_content.node.csv', $this->csvcolumns(), array('header_rows' => 1));

    $this->destination = new MigrateDestinationNode('panopoly_page');

    $this->addFieldMapping('uid')->defaultValue(1);
    $this->addFieldMapping('status')->defaultValue(1);
    $this->addFieldMapping('comment')->defaultValue(0);
    $this->addFieldMapping('language')->defaultValue(LANGUAGE_NONE);
    $this->addFieldMapping('title', 'title');
    $this->addFieldMapping('path', 'export_path');
    $this->addFieldMapping('machine_name', 'machine_name');
    $this->addFieldMapping('body', 'body');
    $this->addFieldMapping('body:format')->defaultValue('panopoly_wysiwyg_text');
    $this->addFieldMapping('created', 'created');
    $this->addUnmigratedDestinations(array(
      'vid'
    ));
  }

  protected function csvcolumns() {
    $columns[0] = array('title', 'Title');
    $columns[1] = array('body', 'Body');
    $columns[2] = array('created', 'Created');
    $columns[3] = array('export_path', 'Path');
    $columns[4] = array('machine_name', 'Machine Name');
    return $columns;
  }
}
