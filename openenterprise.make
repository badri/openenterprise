; $Id:$
core = "6.x"
api = 2

;;;;;;
; sitebuilding tools
;;;;;;

; Allows administrators to define new content types.
projects[cck][subdir] = "contrib"
projects[cck][version] = "2.9"

; Defines a file field type.
projects[filefield][subdir] = "contrib"
projects[filefield][version] = "3.9"

; Defines an image field type.
projects[imagefield][subdir] = "contrib"
projects[imagefield][version] = "3.9"

; Dynamic image manipulator and cache.
projects[imagecache][subdir] = "contrib"
projects[imagecache][version] = "2.0-beta10"

; ImageAPI supporting multiple toolkits.
projects[imageapi][subdir] = "contrib"
projects[imageapi][version] = "1.9"

; Create customized lists and queries from your database.
projects[views][subdir] = "contrib"
projects[views][version] = "2.12"

; Create customized lists and queries from your database.
projects[views_slideshow][subdir] = "contrib"
projects[views_slideshow][version] = "2.3"

; A library of helpful tools by Merlin of Chaos.
projects[ctools][subdir] = "contrib"
projects[ctools][version] = "1.8"

; Defines simple link field types.
projects[link][subdir] = "contrib"
projects[link][version] = "2.9"

; Provides a shared API for replacement of textual placeholders with actual data.
projects[token][subdir] = "contrib"
projects[token][version] = "1.15"

; Provide modules with a cache that lasts for a single page request.
projects[context][subdir] = "contrib"
projects[context][version] = "3.0"

;;;;
; Date and Calendar
;;;;

; Views plugin to display views containing dates as Calendars.
projects[calendar][subdir] = "contrib"
projects[calendar][version] = "2.4"

; Date API that can be used by other modules.
projects[date][subdir] = "contrib"
projects[date][version] = "2.7"

;;;;;;;
; content tools
;;;;;;

; Add markdown syntax input filter.
projects[markdown][subdir] = "contrib"
projects[markdown][version] = "1.2"

; Enable the use of wysiwyg editors.
projects[wysiwyg][subdir] = "contrib"
projects[wysiwyg][version] = "2.3"

; Add better input format support.
projects[better_formats][subdir] = "contrib"
projects[better_formats][version] = "1.2"

; Wiki-style freelinking for node content using CamelCase and delimiters.
projects[freelinking][subdir] = "contrib"
projects[freelinking][version] = "1.10"

; An image/file uploader and browser supporting personal directories and user quota.
projects[imce][subdir] = "contrib"
projects[imce][version] = "1.4"

; Integration for imce and wysiwyg.
projects[imce_wysiwyg][subdir] = "contrib"
projects[imce_wysiwyg][version] = "1.1"

; Tagadelic makes weighted tag clouds from your taxonomy terms.
projects[tagadelic][subdir] = "contrib"
projects[tagadelic][version] = "1.2"

; Tagadelic makes weighted tag clouds from your taxonomy terms.
projects[tagadelic_views][subdir] = "contrib"
projects[tagadelic_views][version] = "1.2"

; Obfuscates email addresses to help prevent spambots from collecting them.
projects[spamspan][subdir] = "contrib"
projects[spamspan][version] = "1.6"

; Add twitter integration
projects[twitter][subdir] = "contrib"
projects[twitter][version] = "2.6"

; Creates AddThis button as a block, to be used in themes and to node links.
projects[addthis][subdir] = "contrib"
projects[addthis][version] = "2.10"

; Build webforms.
projects[webform][subdir] = "contrib"
projects[webform][version] = "3.6"

;;;;;;
; search
;;;;;;

; Improve English language searching by simplifying related words to their root (conjugations, plurals, ...)
projects[porterstemmer][subdir] = "contrib"
projects[porterstemmer][version] = "2.6"

; For page not founds, searches the values entered after the domain name
projects[search404][subdir] = "contrib"
projects[search404][version] = "1.10"

;;;;;;
; exportables
;;;;;;

; Provides feature management for Drupal content types, views, imagecache.
projects[features][subdir] = "contrib"
projects[features][version] = "1.0"

; Provides exports for custom blocks and spaces integration.
projects[boxes][subdir] = "contrib"
projects[boxes][version] = "1.0"

; Enforces variable values defined by modules that need settings set to operate properly.
projects[strongarm][subdir] = "contrib"
projects[strongarm][version] = "2.0"

;;;;;;
; utilities
;;;;;;

; Allows users to export a node and the import into another Drupal installation.
projects[node_export][subdir] = "contrib"
projects[node_export][version] = "2.24"

; jQuery drag and drop ui.
projects[jquery_ui][subdir] = "contrib"
projects[jquery_ui][version] = "1.4"

; An API and home for miscellaneous jQuery plugins.
projects[jquery_plugin][subdir] = "contrib"
projects[jquery_plugin][version] = "1.10"

; Common theme library functionality.
projects[libraries][subdir] = "contrib"
projects[libraries][version] = "1.0"

; Enable a password policy.
projects[password_policy][subdir] = "contrib"
projects[password_policy][version] = "1.0-beta1"

; Enable cron running on systems without cron set up.
projects[poormanscron][subdir] = "contrib"
projects[poormanscron][version] = "2.2"

; Provides a central transliteration service to other Drupal modules, and sanitizes file names while uploading.
projects[transliteration][subdir] = "contrib"
projects[transliteration][version] = "3.0"

; Adds settings checking and fixing.
projects[presets][subdir] = "contrib"
projects[presets][version] = "1.0-rc3"

; change fieldsets to vertial tabs
projects[vertical_tabs][subdir] = "contrib"
projects[vertical_tabs][version] = "1.0-rc1"

;;;;;;
; admin tools
;;;;;;

; UI helpers for Drupal admins and managers. Includes a special admin theme, custom admin header with JS support, and contextual admin links.
projects[admin_menu][subdir] = "contrib"
projects[admin_menu][version] = "1.6"

; Backup or migrate the Drupal Database quickly and without unnecessary data.
projects[backup_migrate][subdir] = "contrib"
projects[backup_migrate][version] = "2.4"

;;;;;;
; dev tools
;;;;;;

projects[devel][subdir] = "devel"
projects[devel][version] = "1.23"

; An API and home for miscellaneous jQuery plugins.
projects[diff][subdir] = "devel"
projects[diff][version] = "2.1"

;;;;;;
; path utilities
;;;;;;

; Input filter to convert internal paths, such as internal:node/99&quot;, to their corresponding absolute URL or relative path.
projects[pathfilter][subdir] = "contrib"
projects[pathfilter][version] = "1.0"

projects[path_redirect][subdir] = "contrib"
projects[path_redirect][version] = "1.0-rc2"

; Provides a mechanism for modules to automatically generate aliases for the content they manage.
projects[pathauto][subdir] = "contrib"
projects[pathauto][version] = "1.5"

; Searches for an alias of the current URL and 301 redirects if found. Stops duplicate content arising when path module is enabled.
projects[globalredirect][subdir] = "contrib"
projects[globalredirect][version] = "1.2"

;;;;;;
; seo tools
;;;;;;

projects[seotools][subdir] = "contrib"
projects[seotools][version] = "1.0-beta5"

; Adds Google Analytics javascript tracking code to all your site's pages.
projects[google_analytics][subdir] = "contrib"
projects[google_analytics][version] = "3.2"

projects[page_title][subdir] = "contrib"
projects[page_title][version] = "2.3"

; Allows users to add meta tags, e.g. keywords or description. This module doesn't actually implement any meta tags, but requires other modules to implement them.
projects[nodewords][subdir] = "contrib"
projects[nodewords][version] = "1.11"

; Analyzes node content for search engine optimization recommendations
projects[contentoptimizer][subdir] = "contrib"
projects[contentoptimizer][version] = "2.2"

; Enhanced control over the page title (in the &lt;head> tag).
projects[page_title][subdir] = "contrib"
projects[page_title][version] = "2.3"

; Displays top searches
; projects[sitesearchstats][subdir] = "contrib"

; Analyze Content
projects[contentanalysis][subdir] = "contrib"
projects[contentanalysis][version] = "1.4"

projects[alchemy][subdir] = "contrib"
projects[alchemy][version] = "1.0-rc4"

projects[linkintel][subdir] = "contrib"
projects[linkintel][version] = "1.0-rc4"

projects[kwresearch][subdir] = "contrib"
projects[kwresearch][version] = "1.0-rc6"

projects[google_analytics_api][subdir] = "contrib"
projects[google_analytics_api][version] = "1.0-alpha1"

projects[chart][subdir] = "contrib"
projects[chart][version] = "1.3"

projects[countries_api][subdir] = "contrib"
projects[countries_api][version] = "1.1"

projects[seo_friend][subdir] = "contrib"
projects[seo_friend][version] = "1.0"

projects[wordstream][subdir] = "contrib"
projects[wordstream][version] = "1.0-beta1"

projects[xmlsitemap][subdir] = "contrib"
projects[xmlsitemap][version] = "2.0-beta2"

projects[w3c_validator][subdir] = "contrib"
projects[w3c_validator][version] = "1.2"

;;;;;
; Libraries
;;;;;

libraries[jquery_ui][download][type] = "get"
libraries[jquery_ui][download][url] = "http://jquery-ui.googlecode.com/files/jquery.ui-1.6.zip"
libraries[jquery_ui][directory_name] = "jquery.ui"
libraries[jquery_ui][destination] = "modules/contrib/jquery_ui"

libraries[ckeditor][download][type] = "get"
libraries[ckeditor][download][url] = "http://download.cksource.com/CKEditor/CKEditor/CKEditor%203.4.2/ckeditor_3.4.2.zip"
libraries[ckeditor][directory_name] = "ckeditor"
libraries[ckeditor][destination] = "libraries"

libraries[alchemy][download][type] = "get"
libraries[alchemy][download][url] = "http://www.alchemyapi.com/tools/AlchemyAPI_PHP5-0.5.1b.tar.gz"
libraries[alchemy][directory_name] = "AlchemyAPI"
libraries[alchemy][destination] = "libraries"

;;;;;;
; theme
;;;;;;

; Allows themes to add conditional stylesheets.
projects[conditional_styles][subdir] = "contrib"
projects[conditional_styles][version] = "1.1"

projects[tao][version] = "3.2"
projects[rubik][version] = "3.0-beta2"
projects[ninesixty][version] = "1.0"
projects[jackson][version] = "1.0"
projects[oe][location] = http://features.leveltendesign.com/fserver
projects[oe][version] = "1.0-ALPHA4"

;;;;;
; features
;;;;;

projects[enterprise][subdir] = "features"
projects[enterprise][version] = "1.0-ALPHA6"
projects[enterprise][location] = http://features.leveltendesign.com/fserver

projects[enterprise_blog][subdir] = "features"
projects[enterprise_blog][version] = "1.0-ALPHA6"
projects[enterprise_blog][location] = http://features.leveltendesign.com/fserver

projects[enterprise_calendar][subdir] = "features"
projects[enterprise_calendar][version] = "1.0-ALPHA3"
projects[enterprise_calendar][location] = http://features.leveltendesign.com/fserver

projects[enterprise_faq][subdir] = "features"
projects[enterprise_faq][version] = "1.0-ALPHA4"
projects[enterprise_faq][location] = http://features.leveltendesign.com/fserver

projects[enterprise_news][subdir] = "features"
projects[enterprise_news][version] = "1.0-ALPHA5"
projects[enterprise_news][location] = http://features.leveltendesign.com/fserver

projects[enterprise_products][subdir] = "features"
projects[enterprise_products][version] = "1.0-ALPHA3"
projects[enterprise_products][location] = http://features.leveltendesign.com/fserver

projects[enterprise_services][subdir] = "features"
projects[enterprise_services][version] = "1.0-ALPHA3"
projects[enterprise_services][location] = http://features.leveltendesign.com/fserver

projects[enterprise_staff][subdir] = "features"
projects[enterprise_staff][version] = "1.0-ALPHA2"
projects[enterprise_staff][location] = http://features.leveltendesign.com/fserver

projects[enterprise_twitter][subdir] = "features"
projects[enterprise_twitter][version] = "1.0-ALPHA2"
projects[enterprise_twitter][location] = http://features.leveltendesign.com/fserver

projects[enterprise_rotator][subdir] = "features"
projects[enterprise_rotator][version] = "1.0-ALPHA3"
projects[enterprise_rotator][location] = http://features.leveltendesign.com/fserver
