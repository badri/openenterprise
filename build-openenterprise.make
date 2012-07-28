api = 2
; to be flexible just use 7.x
; also " are not necessary
core = 7.x

; take the last released Drupal 7.x version
projects[] = drupal


; Missing drupal_alter() for text formats and filters -> it is in wysiwyg dev-
; Version (commit 3e7568e8b8ed077caadcac4dfa147fb394b0b041 , but not in 7.x-2.1)
; see http://drupal.org/node/624018
; http://drupal.org/node/903730
; my suggestion use wysiwyg - dev version until this is in the stable version, 
; expect it in 7.x-2.2
projects[drupal][patch][903730] = http://drupal.org/files/issues/drupal.filter-alter.92.patch

; Use vocabulary machine name for permissions
; http://drupal.org/node/995156
projects[drupal][patch][995156] = http://drupal.org/files/issues/995156-5_portable_taxonomy_permissions.patch

; Fix object menu router conversion issue.
; http://drupal.org/node/972536
projects[drupal][patch][972536] = http://drupal.org/files/issues/drupal-menu-int-972536-78.patch

; Allow password flood to be reset
; http://drupal.org/node/992540
projects[drupal][patch][992540] = http://drupal.org/files/issues/992540-3-reset_flood_limit_on_password_reset-drush.patch

projects[openenterprise][version] = 1.0-rc3
