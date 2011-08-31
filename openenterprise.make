core = "7.x"
api = 2

; Make system directories configurable to allow tests in profiles/[name]/modules to be run.
; http://drupal.org/node/911354
projects[drupal][patch][911354] = http://drupal.org/files/issues/911354.43.patch

; Missing drupal_alter() for text formats and filters
; http://drupal.org/node/903730
projects[drupal][patch][903730] = http://drupal.org/files/issues/drupal.filter-alter.92.patch

; Use vocabulary machine name for permissions
; http://drupal.org/node/995156
projects[drupal][patch][995156] = http://drupal.org/files/issues/995156-5_portable_taxonomy_permissions.patch

;;;;;;
; Fields
;;;;;;
projects[date][subdir] = "contrib"
projects[field_group][subdir] = "contrib"
projects[link][subdir] = "contrib"
projects[options_element][subdir] = "contrib"
projects[references][subdir] = "contrib"

;;;;;;
; Path Tools
;;;;;;
projects[globalredirect][subdir] = "contrib"
projects[pathauto][subdir] = "contrib"
projects[redirect][subdir] = "contrib"
projects[transliteration][subdir] = "contrib"


;;;;;;
; Sitebuilding tools
;;;;;;
projects[apps][subdir] = "contrib"
; Allow modules to define apps servers
; http://drupal.org/node/1255166
projects[apps][patch][1255166] = http://drupal.org/files/issues/add_apps_server_modules-1255166-1.patch

projects[ctools][subdir] = "contrib"
projects[defaultcontent][subdir] = "contrib"
projects[email_registration][subdir] = "contrib"
projects[entity][subdir] = "contrib"
projects[entitycache][subdir] = "contrib"
projects[features][subdir] = "contrib"
projects[libraries][subdir] = "contrib"
projects[password_policy][subdir] = "contrib"
projects[rotating_banner][subdir] = "contrib"
projects[rotating_banner][version] = "1.0-beta1"
projects[strongarm][subdir] = "contrib"
projects[token][subdir] = "contrib"
projects[views][subdir] = "contrib"

;;;;;;
; Text Editor
;;;;;;
projects[htmlpurifier][subdir] = "contrib"
projects[imce][subdir] = "contrib"
projects[imce_wysiwyg][subdir] = "contrib"
projects[wysiwyg][subdir] = "contrib"

;;;;;;
; UI Enhancements
;;;;;;
projects[backports][subdir] = "contrib"
projects[nodeblock][subdir] = "contrib"
projects[nodeconnect][subdir] = "contrib"
projects[simplified_menu_admin][subdir] = "contrib"
projects[simplified_modules][subdir] = "contrib"
projects[ux_elements][subdir] = "contrib"

;;;;;
; Custom
;;;;;

;projects[tutorials][subdir] = "contrib"

;;;;;
; Libraries
;;;;;
libraries[ckeditor][download][type] = "get"
libraries[ckeditor][download][url] = "http://download.cksource.com/CKEditor/CKEditor/CKEditor%203.6.1/ckeditor_3.6.1.zip"
libraries[ckeditor][directory_name] = "ckeditor"
libraries[ckeditor][destination] = "libraries"

libraries[htmlpurifier][download][type] = "get"
libraries[htmlpurifier][download][url] = "http://htmlpurifier.org/releases/htmlpurifier-4.3.0.zip"
libraries[htmlpurifier][directory_name] = "htmlpurifier"
libraries[htmlpurifier][destination] = "libraries"

;;;;;;
; Theme
;;;;;;
