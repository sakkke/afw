# afw

![afw](https://socialify.git.ci/sakkke/afw/image?description=1&descriptionEditable=Arch%20Framework&font=Raleway&forks=1&issues=1&language=1&name=1&owner=1&pattern=Floating%20Cogs&pulls=1&stargazers=1&theme=Light)

It's Arch Framework which helps to install the new system.
It's available in interactive shell and script.

## Interactive Shell

You can try the next commands to install the new system with the preset named `basic`:

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

eval "$(curl https://raw.githubusercontent.com/sakkke/afw/main/afw)"

# Device header lines
AFW_DEVICE_HEADER_LINES=(
  'label: gpt'
)

# Path to EFI file
AFW_EFI_FILE=/GRUB/grubx64.efi

# File systems
AFW_FILESYSTEMS=(
  fat32
  ext4
)

# Bootloader ID for GRUB
AFW_GRUB_BOOTLOADER_ID=GRUB

# Hostname
AFW_HOSTNAME=afw

# /etc/locale.gen
AFW_LOCALE_GEN=(
  'en_US.UTF-8 UTF-8'
)

# Mountpoints
AFW_MOUNTPOINTS=(
  2:/
  1:/boot
)

# Pacman mirrors
AFW_PACMAN_MIRRORS=(
  'https://geo.mirror.pkgbuild.com/$repo/os/$arch'
)

# Packages for the new system
AFW_PACSTRAP_PACKAGES=(
  base
  efibootmgr
  linux
  linux-firmware
  networkmanager
  grub
)

# Partitions
AFW_PARTS=(
  '1 : size=300MiB, type="EFI System"'
  '2 : type="Linux root (x86-64)"'
)

# Passwords
AFW_PASSWORDS=(
  root:afw
)

# Entrypoint for mount
AFW_ROOT=/mnt

# systemd services
AFW_SYSTEMD_SERVICES=(
  NetworkManager.service
)

# Timezone
AFW_TIMEZONE=UTC

# Users
AFW_USERS=()

# User shells
AFW_USER_SHELLS=()

# /etc/vconsole.conf
AFW_VCONSOLE_CONF=(
  KEYMAP=us
)

# Prompt for device which will be installed the new system
if [[ -z $AFW_DEVICE ]]; then
  read -p AFW_DEVICE= AFW_DEVICE
fi

afw update-ntp
afw part
afw format
afw mount
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
afw umount
```
