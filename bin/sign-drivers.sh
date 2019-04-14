#!/usr/bin/env bash

# Virtual Box
/usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 /root/module-signing/mok.priv /root/module-signing/mok.der $(modinfo -n vboxdrv)

# EVDI (Display Link)
/usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 /root/module-signing/mok.priv /root/module-signing/mok.der $(modinfo -n evdi)

echo "Please restart, for this to take effect"
