# afw

![afw](https://socialify.git.ci/sakkke/afw/image?description=1&descriptionEditable=Arch%20Framework&font=Raleway&forks=1&issues=1&language=1&name=1&owner=1&pattern=Floating%20Cogs&pulls=1&stargazers=1&theme=Light)

It's Arch Framework to install the new system.
It's available in interactive shell and script.

## Interactive Shell

You can try the next commands to install the preset named `basic`:

```bash
eval "$(curl https://raw.githubusercontent.com/sakkke/afw/main/afw)"
afw presets/basic
```

You can see available presets in [/src/presets/](https://github.com/sakkke/afw/tree/main/src/presets).

## Script

Add the next one-liner to your script:

```bash
eval "$(curl https://raw.githubusercontent.com/sakkke/afw/main/afw)"
```

The next code is the example script:

```bash
#!/bin/bash

set -eu

eval "$(curl https://raw.githubusercontent.com/sakkke/afw/main/afw)"

declare AFW_DEVICE_LABEL="gpt"
declare AFW_EFI_FILE="/GRUB/grubx64.efi"
declare -a AFW_FILESYSTEMS=(
  fat32
  ext4
)
declare AFW_GRUB_BOOTLOADER_ID="GRUB"
declare AFW_HOSTNAME="afw"
declare -a AFW_LOCALE_GEN=(
  "en_US.UTF-8 UTF-8"
)
declare AFW_MOUNT_ENTRYPOINT="/mnt"
declare -a AFW_MOUNTPOINTS=(
  "2:/"
  "1:/boot"
)
declare -a AFW_PACMAN_MIRRORS=(
  'https://mirror.funami.tech/arch/$repo/os/$arch'
)
declare -a AFW_PACSTRAP_PACKAGES=(
  "base"
  "efibootmgr"
  "linux"
  "linux-firmware"
  "networkmanager"
  "grub"
)
declare -a AFW_PARTS=(
  '1 : size=300MiB, type="EFI System"'
  '2 : type="Linux root (x86-64)"'
)
declare -a AFW_PASSWORDS=(
  "root:afw"
)
declare -a AFW_SYSTEMD_SERVICES=(
  "NetworkManager.service"
)
declare AFW_TIMEZONE="UTC"
declare -a AFW_VCONSOLE_CONF=(
  "KEYMAP=us"
)

if [[ -z "${AFW_DEVICE:-}" ]]; then
  read -p "AFW_DEVICE=" AFW_DEVICE
fi

afw update-ntp
afw part
afw format
afw mount && trap 'afw umount' "EXIT"
afw pacman/update-mirrorlist
afw pacstrap
afw update-fstab
afw update-timezone
afw update-adjtime
afw update-locale_gen
afw update-locale
afw update-vconsole_conf
afw update-hostname
afw update-passwords
afw grub/install
afw grub/install-grub_cfg
afw grub/fix-bootx64_efi
afw systemd/enable-services
```
