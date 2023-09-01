#!/bin/bash
set -e
echo "Setup Shell Startup Files.."

# 9.7 The Bash Shell Startup Files
cat > /etc/profile << "EOF"
# Begin /etc/profile
export LANG=en_GB.ISO-8859-1
# End /etc/profile
EOF