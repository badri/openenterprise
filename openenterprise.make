; $Id:$
core = "6.x"
api = 2

;;;;;;
; sitebuilding tools
;;;;;;

; Allows administrators to define new content types.
projects[cck][subdir] = "contrib"
projects[cck][version] = "2.8"

; Defines a file field type.
projects[filefield][subdir] = "contrib"
projects[filefield][version] = "3.7"

; Defines an image field type.
projects[imagefield][subdir] = "contrib"
projects[imagefield][version] = "3.7"

; Dynamic image manipulator and cache.
projects[imagecache][subdir] = "contrib"
projects[imagecache][version] = "2.0-beta10"

; ImageAPI supporting multiple toolkits.
projects[imageapi][subdir] = "contrib"
projects[imageapi][version] = "1.9"

; Create customized lists and queries from your database.
projects[views][subdir] = "contrib"
projects[views][version] = "2.11"

; Create customized lists and queries from your database.
projects[views_slideshow][subdir] = "contrib"
projects[views_slideshow][version] = "2.11"

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

; Allows users to export a node and the import into another Drupal installation.
projects[node_export][subdir] = "contrib"
projects[node_export][version] = "2.21"

; Google Analytics integration.
projects[google_analytics][subdir] = "contrib"
projects[google_analytics][version] = "3.0"

;;;;
; Date and Calendar
;;;;

; Views plugin to display views containing dates as Calendars.
projects[calendar][subdir] = "contrib"
projects[calendar][version] = "2.2"

; Date API that can be used by other modules.
projects[date][subdir] = "contrib"
projects[date][version] = "2.6"

;;;;;;;
; content tools
;;;;;;

; Enables the usage of CKEditor (WYSIWYG) instead of plain text fields.
projects[ckeditor][subdir] = "contrib"
projects[ckeditor][version] = "1.1"

; Wiki-style freelinking for node content using CamelCase and delimiters.
projects[freelinking][subdir] = "contrib"
projects[freelinking][version] = "1.10"

; An image/file uploader and browser supporting personal directories and user quota.
projects[imce][subdir] = "contrib"
projects[imce][version] = "1.3"

; Tagadelic makes weighted tag clouds from your taxonomy terms.
projects[tagadelic][subdir] = "contrib"
projects[tagadelic][version] = "1.2"

; Adds a 'Tagadelic' style option to views
; projects[views_tagadelic][subdir] = "contrib"

; Add twitter integration
; projects[twitter][subdir] = "contrib"
; projects[twitter][version] = "2.6"

; Creates AddThis button as a block, to be used in themes and to node links.
projects[addthis][subdir] = "contrib"
projects[addthis][version] = "2.9"

; Adds a printer-friendly version link to content and administrative pages.
projects[print][subdir] = "contrib"
projects[print][version] = "1.10"

;;;;;;
; search
;;;;;;

; Improve English language searching by simplifying related words to their root (conjugations, plurals, ...)
projects[porterstemmer][subdir] = "contrib"
projects[porterstemmer][version] = "2.5"

; For page not founds, searches the values entered after the domain name
projects[search404][subdir] = "contrib"
projects[search404][version] = "1.9"

;;;;;;
; exportables
;;;;;;

; Provides feature management for Drupal content types, views, imagecache.
projects[features][subdir] = "contrib"
projects[features][version] = "1.0"

; Provides exports for custom blocks and spaces integration.
projects[boxes][subdir] = "contrib"
projects[boxes][version] = "1.0-beta4"

; Enforces variable values defined by modules that need settings set to operate properly.
projects[strongarm][subdir] = "contrib"
projects[strongarm][version] = "2.0"

; jQuery drag and drop ui.
projects[jquery_ui][subdir] = "contrib"
projects[jquery_ui][version] = "1.4"

; Common theme library functionality.
projects[libraries][subdir] = "contrib"
projects[libraries][version] = "1.0-alpha1"

;;;;;;
; admin tools
;;;;;;

; UI helpers for Drupal admins and managers. Includes a special admin theme, custom admin header with JS support, and contextual admin links.
projects[admin][subdir] = "contrib"
projects[admin][version] = "2.0"

; Backup or migrate the Drupal Database quickly and without unnecessary data.
projects[backup_migrate][subdir] = "contrib"
projects[backup_migrate][version] = "2.2"

;;;;;;
; theme
;;;;;;

; Allows themes to add conditional stylesheets.
projects[conditional_styles][subdir] = "contrib"
projects[conditional_styles][version] = "1.1"

;;;;;;
; dev tools
;;;;;;

; An API and home for miscellaneous jQuery plugins.
projects[jquery_plugin][subdir] = "contrib"
projects[jquery_plugin][version] = "1.10"

;;;;;;
; passive utilities
;;;;;;

; Input filter to convert internal paths, such as internal:node/99&quot;, to their corresponding absolute URL or relative path.
projects[pathfilter][subdir] = "contrib"
projects[pathfilter][version] = "1.0"

; Provides a mechanism for modules to automatically generate aliases for the content they manage.
projects[pathauto][subdir] = "contrib"
projects[pathauto][version] = "1.5"

; Searches for an alias of the current URL and 301 redirects if found. Stops duplicate content arising when path module is enabled.
projects[globalredirect][subdir] = "contrib"
projects[globalredirect][version] = "1.2"

;;;;;;
; seo tools
;;;;;;

; Adds Google Analytics javascript tracking code to all your site's pages.
projects[google_analytics][subdir] = "contrib"
projects[google_analytics][version] = "3.0"

; Allows users to add meta tags, e.g. keywords or description. This module doesn't actually implement any meta tags, but requires other modules to implement them.
projects[nodewords][subdir] = "contrib"
projects[nodewords][version] = "1.11"

; Analyzes node content for search engine optimization recommendations
projects[contentoptimizer][subdir] = "contrib"
projects[contentoptimizer][version] = "2.0-beta1"

; Enhanced control over the page title (in the &lt;head> tag).
projects[page_title][subdir] = "contrib"
projects[page_title][version] = "2.3"

; Displays top searches
; projects[sitesearchstats][subdir] = "contrib"

; Analyze Content
projects[contentanalysis][subdir] = "contrib"
projects[contentanalysis][version] = "1.0-beta1"

; Readability Analyzer
projects[readability][subdir] = "contrib"
projects[readability][version] = "1.0-beta1"

; ScribeSEO Analyzer
projects[scribeseo][subdir] = "contrib"
projects[scribeseo][version] = "1.0-beta1"

; WC3 Analyzer
projects[w3canalyzer][subdir] = "contrib"
projects[w3canalyzer][version] = "1.0-beta1"

; Content Optimizer Analyzer
projects[contentoptimizer][subdir] = "contrib"
projects[contentoptimizer][version] = "2.1"

;;;;;
; Libraries
;;;;;

libraries[jquery_ui][download][type] = "get"
libraries[jquery_ui][download][url] = "http://jquery-ui.googlecode.com/files/jquery.ui-1.6.zip"
libraries[jquery_ui][directory_name] = "jquery.ui"
libraries[jquery_ui][destination] = "modules/contrib/jquery_ui"

;;;;;;
; themes
;;;;;;

projects[tao][version] = "3.1"
projects[rubik][version] = "3.0-beta2"
projects[danland][version] = "2.0"

;;;;;
; features
;;;;;

projects[enterprise][subdir] = "features"
projects[enterprise][version] = "1.0-ALPHA2"
projects[enterprise][location] = http://features.leveltendesign.com/fserver

projects[enterprise_blog][subdir] = "features"
projects[enterprise_blog][version] = "1.0-ALPHA2"
projects[enterprise_blog][location] = http://features.leveltendesign.com/fserver

projects[enterprise_calendar][subdir] = "features"
projects[enterprise_calendar][version] = "1.0-ALPHA2"
projects[enterprise_calendar][location] = http://features.leveltendesign.com/fserver

projects[enterprise_faq][subdir] = "features"
projects[enterprise_faq][version] = "1.0-ALPHA2"
projects[enterprise_faq][location] = http://features.leveltendesign.com/fserver

projects[enterprise_news][subdir] = "features"
projects[enterprise_news][version] = "1.0-ALPHA2"
projects[enterprise_news][location] = http://features.leveltendesign.com/fserver

projects[enterprise_products][subdir] = "features"
projects[enterprise_products][version] = "1.0-ALPHA2"
projects[enterprise_products][location] = http://features.leveltendesign.com/fserver

projects[enterprise_services][subdir] = "features"
projects[enterprise_services][version] = "1.0-ALPHA2"
projects[enterprise_services][location] = http://features.leveltendesign.com/fserver

projects[enterprise_twitter][subdir] = "features"
projects[enterprise_twitter][version] = "1.0-ALPHA2"
projects[enterprise_twitter][location] = http://features.leveltendesign.com/fserver

projects[enterprise_rotator][subdir] = "features"
projects[enterprise_rotator][version] = "1.0-ALPHA2"
projects[enterprise_rotator][location] = http://features.leveltendesign.com/fserver
