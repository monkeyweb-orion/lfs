#!/bin/bash
set -e
echo "Building Ninja.."
echo "Approximate build time: 0.6 SBU"
echo "Required disk space: 79 MB"

# 8.52. Ninja is a small build system with a focus on speed.
tar -xf /sources/ninja-*.tar.gz -C /tmp/ \
    && mv /tmp/ninja-* /tmp/ninja \
    && pushd /tmp/ninja

# Using the optional patch below allows a user to limit the number of parallel processes
# via an environment variable, NINJAJOBS. For example setting:
export NINJAJOBS=$JOB_COUNT

# If desired, add the capability to use the environment variable NINJAJOBS by running:
sed -i '/int Guess/a \
  int   j = 0;\
  char* jobs = getenv( "NINJAJOBS" );\
  if ( jobs != NULL ) j = atoi( jobs );\
  if ( j > 0 ) return j;\
' src/ninja.cc

# Build package
python3 configure.py --bootstrap

# Run tests
if [ $LFS_TEST -eq 1 ]; then
    ./ninja ninja_test
    ./ninja_test --gtest_filter=-SubprocessTest.SetWithLots
fi

# Install package
install -vm755 ninja /usr/bin/
install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
install -vDm644 misc/zsh-completion /usr/share/zsh/site-functions/_ninja

# cleanup
popd \
    && rm -rf /tmp/python
