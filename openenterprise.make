api = 2
core = 7.x

;;;;;;
; Fields
;;;;;;
projects[date][version] = 2.6
projects[entityreference][version] = 1.0
projects[ffc][version] = 1.0-beta2
projects[field_delimiter][version] = 1.0
projects[field_formatter_class][version] = 1.1
projects[field_formatter_settings][version] = 1.0
projects[field_group][version] = 1.1
projects[field_word_boundary][version] = 1.0-beta3
projects[filefield_sources][version] = 1.7
projects[image_url_formatter][version] = 1.0
projects[link][version] = 1.1
projects[options_element][version] = 1.8

;;;;;;
; Path Tools
;;;;;;
projects[globalredirect][version] = 1.5
projects[pathauto][version] = 1.2
projects[redirect][version] = 1.0-rc1
projects[transliteration][version] = 3.1

;;;;;;
; Sitebuilding tools
;;;;;;
projects[apps][version] = 1.0-beta7
projects[blockgroup][version] = 1.0-rc1
projects[block_class][version] = 1.2
projects[ctools][version] = 1.2
projects[defaultcontent][version] = 1.0-alpha9
projects[ds][version] = 2.2
projects[entity][version] = 1.0
projects[entitycache][version] = 1.1
projects[features][version] = 2.0-beta2
projects[libraries][version] = 2.1
projects[menu_attributes][version] = 1.0-rc2
projects[menu_block][version] = 2.3
projects[strongarm][version] = 2.0
projects[token][version] = 1.5
projects[views][version] = 3.6
projects[views_bulk_operations][version] = 3.1
projects[views_responsive_grid][version] = 1.2

;;;;;;
; Text Editor
;;;;;;
projects[imce][version] = 1.7
projects[imce_wysiwyg][version] = 1.0
projects[better_formats][version] = 1.0-beta1
projects[insert][version] = 1.3
projects[caption_filter][version] = 1.2
projects[image_resize_filter][version] = 1.13
projects[wysiwyg][version] = 2.2
projects[wysiwyg_filter][version] = 1.6-rc2

;;;;;;
; UI Enhancements
;;;;;;
projects[admin_menu][version] = 3.0-rc4
projects[block_visibility][version] = 1.0-beta2
projects[email_registration][version] = 1.1
projects[jquery_update][version] = 2.3
projects[module_filter][version] = 1.7
projects[menu_trail_by_path][version] = 2.0
projects[navigation404][version] = 1.0
projects[simplified_menu_admin][version] = 1.0-beta2

;;;;;
; Libraries
;;;;;

libraries[tinymce][download][type] = file
libraries[tinymce][download][url] = https://github.com/downloads/tinymce/tinymce/tinymce_3.5.8_jquery.zip
libraries[tinymce][directory_name] = tinymce
libraries[tinymce][destination] = libraries

;;;;;;
; Themes
;;;;;;

projects[bootstrap][version] = 2.x-dev
projects[bootstrap][type] = theme
; [META] Refactor code to allow for either CDN or sub-theme source files.
; http://drupal.org/node/1957620
projects[bootstrap][patch][1957620] = http://drupal.org/files/1957620-bootstrap-refactor_code_cdn-1.patch
; Add sub-theme starter kit
; http://drupal.org/node/1844448
projects[bootstrap][patch][1844448] = http://drupal.org/files/1844448-bootstrap-subtheme-52.patch
projects[tao][version] = 3.0-beta4
projects[tao][type] = theme
projects[tao][patch][1212314] = http://drupal.org/files/0001-Issue-1212314-by-ericduran-Fixed-Fieldgroup-legend-t.patch
projects[rubik][version] = 4.0-beta8
projects[rubik][type] = theme
