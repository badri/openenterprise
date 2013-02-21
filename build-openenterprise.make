api = 2
core = 7.x

; Latest Drupal Core
projects[] = drupal

; Missing drupal_alter() for text formats and filters
; http://drupal.org/node/903730
projects[drupal][patch][903730] = http://drupal.org/files/issues/drupal.filter-alter.92.patch

; Use vocabulary machine name for permissions
; http://drupal.org/node/995156
projects[drupal][patch][995156] = http://drupal.org/files/taxonomy-995156-32.patch

; Fix object menu router conversion issue.
; http://drupal.org/node/972536
projects[drupal][patch][972536] = http://drupal.org/files/drupal-menu-int-972536-83-D7.patch

; Allow password flood to be reset
; http://drupal.org/node/992540
projects[drupal][patch][992540] = http://drupal.org/files/issues/992540-3-reset_flood_limit_on_password_reset-drush.patch

; Two nested contextual links regions are active, when the outer region is hovered.
; http://drupal.org/node/1216776
projects[drupal][patch][1216776] = http://drupal.org/files/1216776-contextual-links-nested-23-d7.patch

projects[openenterprise][type] = profile
projects[openenterprise][version] = 7.x-2.x-dev
projects[openenterprise][download][type] = git
projects[openenterprise][download][url] = file:///server/repositories/drupal/openenterprise/.git
;projects[openenterprise][download][tag] = 7.x-2.x
projects[openenterprise][download][revision] = 7.x-2.x
