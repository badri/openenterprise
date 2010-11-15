#!/bin/bash
#
# This command expects to be run within the Open Enterprise profile directory. To
# generate a full distribution you it must be a CVS checkout.
#
# To use this command you must have `drush make`, `cvs` and `git` installed.
#

if [ -f openenterprise.make ]; then
  echo -e "\nThis command can be used to run openenterprise.make in place, or to generate"
  echo -e "a complete distribution of Open Enterprise.\n\nWhich would you like?"
  echo "  [1] Rebuild Open Enterprise in place."
  echo "  [2] Build a full Open Enterprise distribution"
  echo -e "Selection: \c"
  read SELECTION

  if [ $SELECTION = "1" ]; then

    # Run openenterprise.make only.
    echo "Building Open Enterprise install profile..."
    drush make --working-copy --no-core --contrib-destination=. openenterprise.make

  elif [ $SELECTION = "2" ]; then

    # Generate a complete tar.gz of Drupal + Open Enterprise.
    echo "Building Open Enterprise distribution..."

MAKE=$(cat <<EOF
core = "6.x"\n
projects[drupal][version] = "6.19"\n
projects[openenterprise][type] = "profile"\n
projects[openenterprise][download][type] = "cvs"\n
projects[openenterprise][download][module] = "contributions/profiles/openenterprise"\n
projects[openenterprise][download][revision] =
EOF
)

    TAG=`cvs status openenterprise.make | grep "Sticky Tag:" | awk '{print $3}'`
    if [ -n $TAG ]; then
      if [ $TAG = "(none)" ]; then
        TAG="HEAD"
        VERSION="head"
      elif [ $TAG = "HEAD" ]; then
        VERSION="head"
      else
        VERSION="${TAG:10}"
      fi
      MAKE="$MAKE $TAG\n"
      NAME=`echo "Enterprise-$VERSION" | tr '[:upper:]' '[:lower:]'`
      echo -e $MAKE | drush make --yes --tar - $NAME
    else
      echo 'Could not determine CVS tag. Is openenterprise.make a CVS checkout?'
    fi
  else
   echo "Invalid selection."
  fi
else
  echo 'Could not locate file "openenterprise.make"'
fi
