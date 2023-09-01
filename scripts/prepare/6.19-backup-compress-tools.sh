#!/bin/bash
# 6.19. Backup Compress Tools
sudo -E -u root /bin/bash - << EOF
sudo chown -Rv root:root $LFS/tools
tar -cvf $LFS/tools.tar -C $LFS tools
EOF