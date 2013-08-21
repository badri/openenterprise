api = 2
core = 7.x

;;;;;;
; Fields
;;;;;;
projects[addressfield][version] = 1.0-beta4
; Support microdata in addressfield
; http://drupal.org/node/1259582
projects[addressfield][patch][1259582] = https://drupal.org/files/1259582-14-microdata.patch
; Address component Views support
; http://drupal.org/node/991834
projects[addressfield][patch][991834] = https://drupal.org/files/addressfield-views_components-991834-90.patch
projects[date][version] = 2.6
; Add microdata support to date module.
; http://drupal.org/node/1266688
projects[date][patch][1266688] = http://drupal.org/files/1266688-33-microdata-support.patch
projects[entityreference][version] = 1.0
projects[ffc][version] = 1.0-beta2
projects[field_delimiter][version] = 1.0
; Undefined index: field_delimiter & Undefined index: cardinality
; http://drupal.org/node/1961498
projects[field_delimiter][patch][1961498] = http://drupal.org/files/1961498-field_delimiter-undefined_indexes-1.patch
projects[field_formatter_class][version] = 1.1
projects[field_formatter_settings][version] = 1.0
projects[field_group][version] = 1.1
projects[field_word_boundary][version] = 1.0-beta3
projects[filefield_sources][version] = 1.8
projects[image_url_formatter][version] = 1.0
projects[link][version] = 1.1
projects[linked_field][version] = 1.8
projects[media][version] = 2.x-dev
; Media file selector widget window sizing is off
; https://drupal.org/node/2032255
projects[media][patch][2032255] = https://drupal.org/files/2032255-4-media-widget-window-sizing.patch
projects[file_entity][version] = 2.x-dev
projects[options_element][version] = 1.9

;;;;;;
; Path Tools
;;;;;;
projects[globalredirect][version] = 1.5
projects[pathauto][version] = 1.2
projects[redirect][version] = 1.0-rc1
; How to fix and/or prevent circular redirects
; http://drupal.org/node/1796596
projects[redirect][patch][1796596] = https://drupal.org/files/redirect_loop_detection-1796596-68-reroll.patch
projects[transliteration][version] = 3.1

;;;;;;
; Sitebuilding tools
;;;;;;
projects[bean][version] = 1.2
projects[breakpoints][version] = 1.1
projects[blocker][version] = 1.0-alpha2
projects[block_class][version] = 1.2
projects[block_row][version] = 1.0-alpha1
projects[block_views][version] = 1.0-beta2
projects[ctools][version] = 1.3
projects[ds][version] = 2.4
projects[entity][version] = 1.1
projects[entitycache][version] = 1.1
projects[features][version] = 2.0-rc2
projects[icon][version] = 1.0-beta3
projects[libraries][version] = 2.1
projects[menu_attributes][version] = 1.0-rc2
projects[menu_block][version] = 2.3
projects[picture][version] = 1.x-dev
; CKEditor: Advanced tab in image dialog missing
; http://drupal.org/node/2023765
projects[picture][patch][2023765] = https://drupal.org/files/picture-ckeditor-advanced-2023765-2.patch
projects[strongarm][version] = 2.0
projects[token][version] = 1.5
projects[views][version] = 3.7
projects[views_bulk_operations][version] = 3.1
projects[views_responsive_grid][version] = 1.3

;;;;;;
; Text Editor
;;;;;;
projects[ajax_markup][version] = 1.0
projects[better_formats][version] = 1.0-beta1
projects[ckeditor][version] = 1.x-dev
projects[video_filter][version] = 3.x-dev
; video filter dialog with ckeditor standalone module is not working
; http://drupal.org/node/1689440
projects[video_filter][patch][1689440] = https://drupal.org/files/video_filter-video-filter-dialog-1689440-5.patch

;;;;;;
; UI Enhancements
;;;;;;
projects[admin_menu][version] = 3.0-rc4
projects[block_visibility][version] = 1.0-beta2
projects[email_registration][version] = 1.1
projects[jquery_update][version] = 2.3
; Allow different version for administrative pages
; http://drupal.org/node/1524944
projects[jquery_update][patch][1524944] = http://drupalcode.org/project/jquery_update.git/patch/469fac05d630668d6f3d8e24fef60c35614ff0ca
; Update jQuery UI to the latest version (1.10.2)
; http://drupal.org/node/1947438
projects[jquery_update][patch][1947438] = http://drupalcode.org/project/jquery_update.git/patch/d32f50d45b54b1b1f6430ea09b83f005032075f0
projects[module_filter][version] = 1.7
projects[menu_trail_by_path][version] = 2.0
projects[simplified_menu_admin][version] = 1.0-beta2

;;;;;
; SEO Modules
;;;;;
projects[xmlsitemap][version] = 2.0-rc2
projects[microdata][version] = 1.0-beta2
projects[navigation404][version] = 1.0
projects[search404][version] = 1.3

;;;;;
; Libraries
;;;;;
libraries[ckeditor][download][type] = file
libraries[ckeditor][download][url] = http://download.cksource.com/CKEditor/CKEditor/CKEditor%204.2/ckeditor_4.2_full.zip
libraries[ckeditor][directory_name] = ckeditor
libraries[ckeditor][destination] = libraries

;;;;;;
; Themes
;;;;;;

projects[bootstrap][version] = 2.x-dev
projects[bootstrap][type] = theme
projects[tao][version] = 3.0-beta4
projects[tao][type] = theme
projects[tao][patch][1212314] = http://drupal.org/files/0001-Issue-1212314-by-ericduran-Fixed-Fieldgroup-legend-t.patch
projects[rubik][version] = 4.0-beta9
projects[rubik][type] = theme
