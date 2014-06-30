; To generate with Drush make, copy this file to e.g. stub.make 
; and enter in your shell / command line:
; drush make --prepare-install stub.make folder_of_your_site

core = 7.x
api = 2

; drupal core latest release of specified core = number.x
projects[] = drupal

projects[openenterprise][type] = profile
projects[openenterprise][download][type] = git
projects[openenterprise][download][url] = https://github.com/badri/openenterprise
projects[openenterprise][download][branch] = pp-slideshow

; for a local build
; includes[] = drupal-org.make

; Add in some apps (optional). These can also be added later from the Apps page.
;projects[socialmedia][location] = http://apps.leveltendesign.com/fserver
;projects[seotools][location] = http://apps.leveltendesign.com/fserver
;projects[seo][location] = http://apps.leveltendesign.com/fserver
;projects[enterprise_blog][location] = http://apps.leveltendesign.com/fserver
;projects[enterprise_rotator][location] = http://apps.leveltendesign.com/fserver
;projects[enterprise_events][location] = http://apps.leveltendesign.com/fserver
;projects[enterprise_faq][location] = http://apps.leveltendesign.com/fserver
;projects[enterprise_forum][location] = http://apps.leveltendesign.com/fserver
;projects[enterprise_links][location] = http://apps.leveltendesign.com/fserver
;projects[enterprise_location][location] = http://apps.leveltendesign.com/fserver
;projects[enterprise_images][location] = http://apps.leveltendesign.com/fserver
;projects[enterprise_video][location] = http://apps.leveltendesign.com/fserver
; i can't find careers on the fserver, can someone please test?
;projects[enterprise_careers][location] = http://apps.leveltendesign.com/fserver
;projects[development][location] = http://apps.leveltendesign.com/fserver
