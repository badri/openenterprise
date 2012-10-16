api = 2
core = 7.x

;;;;;;
; Fields
;;;;;;
projects[date][subdir] = contrib
projects[field_group][subdir] = contrib
projects[link][subdir] = contrib
projects[options_element][subdir] = contrib
projects[references][subdir] = contrib
projects[filefield_sources][subdir] = contrib

;;;;;;
; Path Tools
;;;;;;
projects[globalredirect][subdir] = contrib
projects[pathauto][subdir] = contrib
projects[redirect][subdir] = contrib
projects[transliteration][subdir] = contrib


;;;;;;
; Sitebuilding tools
;;;;;;
projects[apps][subdir] = contrib
projects[backup_migrate][subdir] = contrib
projects[boxes][subdir] = contrib
projects[ctools][subdir] = contrib
projects[custom_formatters][subdir] = contrib
projects[defaultcontent][version] = 1.0-alpha6
; Remove context dependency.
; http://drupal.org/node/1446714
projects[defaultcontent][patch][1446714] = http://drupal.org/files/defaultcontent-1446714-16.patch
projects[ds][subdir] = contrib
projects[email_registration][subdir] = contrib
projects[entity][subdir] = contrib
projects[entitycache][subdir] = contrib
projects[features][subdir] = contrib
projects[features_override][subdir] = contrib
projects[libraries][subdir] = contrib
projects[menu_block][subdir] = contrib
projects[panels][subdir] = contrib
projects[strongarm][subdir] = contrib
projects[token][subdir] = contrib
projects[total_control][subdir] = contrib
projects[views][subdir] = contrib
projects[views_bulk_operations][subdir] = contrib

;;;;;;
; Text Editor
;;;;;;
projects[imce][subdir] = contrib
projects[imce_wysiwyg][subdir] = contrib
projects[better_formats][subdir] = contrib
projects[insert][subdir] = contrib
projects[caption_filter][subdir] = contrib
projects[image_resize_filter][subdir] = contrib
projects[wysiwyg][subdir] = contrib
projects[wysiwyg_filter][subdir] = contrib

;;;;;;
; UI Enhancements
;;;;;;
projects[backports][subdir] = contrib
projects[block_visibility][subdir] = contrib
projects[nodeconnect][subdir] = contrib
projects[simplified_menu_admin][subdir] = contrib
projects[elements][subdir] = contrib
projects[admin_menu][subdir] = contrib
projects[navigation404][subdir] = contrib

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
