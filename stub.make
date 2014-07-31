; To generate with Drush make, copy this file to e.g. stub.make
; and enter in your shell / command line:
; drush make --prepare-install stub.make folder_of_your_site

core = 7.x
api = 2

; drupal core latest release of specified core = number.x
projects[] = drupal

projects[druplug][type] = profile
projects[druplug][download][type] = git
projects[druplug][download][url] = https://github.com/badri/druplug
projects[druplug][download][branch] = 1.x

; for a local build
; includes[] = drupal-org.make
