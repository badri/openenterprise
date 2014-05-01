api = 2
core = 7.x

;;;;;;
; Fields
;;;;;;
projects[date][type] = module
projects[field_group][type] = module
projects[link][type] = module
projects[options_element][type] = module
projects[references][type] = module
projects[filefield_sources][type] = module

;;;;;;
; Path Tools
;;;;;;
projects[globalredirect][type] = module
projects[pathauto][type] = module
projects[redirect][type] = module
projects[transliteration][type] = module


;;;;;;
; Sitebuilding tools
;;;;;;
projects[apps][type] = module
projects[backup_migrate][type] = module
projects[boxes][type] = module
projects[ctools][type] = module
projects[custom_formatters][type] = module
projects[defaultcontent][version] = 1.0-alpha6
projects[defaultcontent][type] = module
; Remove context dependency.
; http://drupal.org/node/1446714
projects[defaultcontent][patch][1446714] = http://drupal.org/files/defaultcontent-1446714-16.patch
projects[ds][type] = module
projects[email_registration][type] = module
projects[entity][type] = module
projects[entitycache][type] = module
projects[features][type] = module
projects[features_override][type] = module
projects[libraries][type] = module
projects[menu_block][type] = module
projects[panels][type] = module
projects[strongarm][type] = module
projects[token][type] = module
projects[total_control][type] = module
projects[views][type] = module
projects[views_bulk_operations][type] = module

;;;;;;
; Text Editor
;;;;;;
projects[imce][type] = module
projects[imce_wysiwyg][type] = module
projects[better_formats][type] = module
projects[insert][type] = module
projects[caption_filter][type] = module
projects[image_resize_filter][type] = module
projects[wysiwyg][type] = module
projects[wysiwyg_filter][type] = module

;;;;;;
; UI Enhancements
;;;;;;
projects[backports][type] = module
projects[block_visibility][type] = module
projects[nodeconnect][type] = module
projects[simplified_menu_admin][type] = module
projects[elements][type] = module
projects[admin_menu][type] = module
projects[navigation404][type] = module

;;;;;
; Libraries
;;;;;

libraries[tinymce][download][type] = file
libraries[tinymce][download][url] = http://github.com/downloads/tinymce/tinymce/tinymce_3.5.6.zip
libraries[tinymce][directory_name] = tinymce
libraries[tinymce][destination] = libraries

;;;;;;
; Themes
;;;;;;

projects[tao][type] = theme
projects[rubik][type] = theme
projects[omega][version] = 3.1
projects[omega][patch][1343274] = http://drupal.org/files/omega-ie7_0.patch
projects[navin][type] = theme
