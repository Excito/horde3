#!/bin/sh
# Repack upstream source to remove fckeditor, tinymce and scriptaculous
# (size of upstream source is now 7 Mo instead of 8 Mo)

# HOWTO :
# % wget ftp://ftp.horde.org/pub/horde/horde-3.2.1.tar.gz 
# % cleanup.sh horde-3.2.1.tar.gz

set -e

# I want an argument
if [ "$1" = "" ]; then
    echo "$0: needs a .tar.gz filename argument"
    exit 1
fi

PKG=$(basename $1)
TMPDIR=$(mktemp -d)
WHERE=$(pwd)

# copy stuff in temp dir
if ! cp $1 $TMPDIR; then
    echo "$1 isn't a valid filename"
    exit 1
fi

cd $TMPDIR

# extract files
if ! tar -zxf $1; then
    echo "$1 isn't a valid tarball"
    exit 1
fi

#don't remove xinha as it is not packaged yet
#rm -rf horde-3.2/services/editor/xinha
# Remove fckeditor, tinymce, scriptaculous...
rm -rf horde-3.2.1/services/editor/fckeditor
rm -rf horde-3.2.1/services/editor/tinymce
rm -f horde-3.2.1/js/controls.js
rm -f horde-3.2.1/js/src/controls.js
rm -f horde-3.2.1/js/dragdrop.js
rm -f horde-3.2.1/js/src/dragdrop.js
rm -f horde-3.2.1/js/effects.js
rm -f horde-3.2.1/js/src/effects.js
rm -f horde-3.2.1/js/prototype.js
rm -f horde-3.2.1/js/src/prototype.js
rm -f horde-3.2.1/js/scriptaculous.js
rm -f horde-3.2.1/js/src/scriptaculous.js
rm -f horde-3.2.1/js/slider.js
rm -f horde-3.2.1/js/src/slider.js

# Create the new source
tar -czf horde3_3.2.1+debian0.orig.tar.gz horde-3.2.1/

mv horde3_3.2.1+debian0.orig.tar.gz $WHERE
rm -rf $TMPDIR

