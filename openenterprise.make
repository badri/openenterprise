api = 2
core = 7.x

;;;;;;
; Fields
;;;;;;
projects[references][type] = module
projects[filefield_sources][type] = module

;;;;;;
; Path Tools
;;;;;;
projects[globalredirect][type] = module
projects[redirect][type] = module
projects[transliteration][type] = module


;;;;;;
; Sitebuilding tools
;;;;;;
projects[backup_migrate][type] = module
projects[boxes][type] = module
projects[custom_formatters][type] = module
projects[custom_formatters][version] = 2.x-dev
projects[defaultcontent][version] = 1.0-alpha6
projects[defaultcontent][type] = module
; Remove context dependency.
; http://drupal.org/node/1446714
projects[defaultcontent][patch][1446714] = http://drupal.org/files/defaultcontent-1446714-16.patch
projects[ds][type] = module
projects[email_registration][type] = module
projects[entitycache][type] = module
projects[features_override][type] = module
projects[total_control][type] = module
projects[panels_everywhere][type] = module
projects[panels_everywhere][version] = 1.x-dev

;;;;;;
; Text Editor
;;;;;;
projects[better_formats][type] = module
projects[insert][type] = module

;;;;;;
; UI Enhancements
;;;;;;
projects[block_visibility][type] = module
projects[nodeconnect][type] = module
projects[elements][type] = module
projects[navigation404][type] = module
projects[options_element][type] = module

; The Panopoly Foundation
projects[panopoly_core][version] = 1.1
projects[panopoly_core][subdir] = panopoly
projects[panopoly_images][version] = 1.1
projects[panopoly_images][subdir] = panopoly
projects[panopoly_theme][version] = 1.1
projects[panopoly_theme][subdir] = panopoly
projects[panopoly_magic][version] = 1.1
projects[panopoly_magic][subdir] = panopoly
projects[panopoly_widgets][version] = 1.1
projects[panopoly_widgets][subdir] = panopoly
projects[panopoly_admin][version] = 1.1
projects[panopoly_admin][subdir] = panopoly
projects[panopoly_users][version] = 1.1
projects[panopoly_users][subdir] = panopoly
; The Panopoly Toolset
projects[panopoly_pages][version] = 1.1
projects[panopoly_pages][subdir] = panopoly
projects[panopoly_wysiwyg][version] = 1.1
projects[panopoly_wysiwyg][subdir] = panopoly
projects[panopoly_search][version] = 1.1
projects[panopoly_search][subdir] = panopoly

;;;;;
; Libraries
;;;;;

;;;;;;
; Themes
;;;;;;

projects[tao][type] = theme
projects[rubik][type] = theme
projects[omega][type] = theme

; Kappa is still a sandbox theme
projects[kappa][type] = theme
projects[kappa][download][type] = git
projects[kappa][download][branch] = 7.x-1.x
projects[kappa][download][url] = http://git.drupal.org/sandbox/badri/2264805.git
