To generate with Drush make, create a stub.make file and enter:

core = "7.x"
api = 2

projects[drupal][type] = core
projects[drupal][version] = "7.8"

projects[openenterprise][type] = profile
projects[openenterprise][download][type] = git
projects[openenterprise][download][url] = git://github.com/levelten/openenterprise.git
projects[openenterprise][download][revision] = DRUPAL-7--1-0-ALPHA1
