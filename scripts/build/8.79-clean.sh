#!/bin/bash
set -e
echo "Cleaning up.."

# 8.79. Cleaning Up

# Finally, clean up some extra files left 
# around from running tests:
rm -rf /tmp/*

find /usr/lib /usr/libexec -name \*.la -delete

# Finally, remove the temporary 'tester' user account 
# created at the beginning of the previous chapter.
find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf

# Finally, remove the temporary 'tester' user account
# created at the beginning of the previous chapter.
userdel -r tester