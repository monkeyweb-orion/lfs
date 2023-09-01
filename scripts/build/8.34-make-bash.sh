#!/bin/bash
set -e
echo "Building bash"
echo "Approximate build time: 1.4 SBU"
echo "Required disk space: 50 MB"

# 8.34. The Bash package contains the Bourne-Again Shell.
tar -xf /sources/bash-*.tar.gz -C /tmp/ \
    && mv /tmp/bash-* /tmp/bash \
    && pushd /tmp/bash

# prepare bash
./configure --prefix=/usr               \
    --docdir=/usr/share/doc/bash-5.1.16 \
    --without-bash-malloc               \
    --with-installed-readline

# Compile the package
make

# Run tests
if [ $LFS_TEST -eq 1 ]
    then
    # To prepare the tests, ensure that the nobody user can write to the sources tree
    chown -Rv tester .
    # Now, run the tests as the nobody user:
    
su -s /usr/bin/expect tester << EOF
set timeout -1
spawn make tests
expect eof
lassign [wait] _ _ _ value
exit $value
EOF

fi

# Install the package and move the main executable to /bin
make install
exec /usr/bin/bash --login

# cleanup
popd \
    && rm -rf /tmp/bash
