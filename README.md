<div align="center">

# afw

Arch Framework ⚙️

[![GitHub contributers](https://img.shields.io/github/contributors/sakkke/afw)]()
[![GitHub forks](https://img.shields.io/github/forks/sakkke/afw)]()
[![GitHub issues](https://img.shields.io/github/issues/sakkke/afw)]()
[![GitHub license](https://img.shields.io/github/license/sakkke/afw)]()
[![GitHub pull requests](https://img.shields.io/github/issues-pr/sakkke/afw)]()
[![GitHub stars](https://img.shields.io/github/stars/sakkke/afw)]()

[![Discord](https://img.shields.io/discord/1012345440873742436?color=%235865F2&label=Discord&logo=Discord&logoColor=%23FFF)](https://discord.gg/HYKfDBMkyq)

</div>

---

[![asciicast](https://asciinema.org/a/517447.svg)](https://asciinema.org/a/517447)

## Overview

It's Arch Framework which helps to install the new system.
It's available in interactive shell and script.

### Good Points

- Simple structure
- Easy installation of Arch Linux
- Highly customizable
- Custom entry point support

We can add the desktop environment (GNOME, KDE, etc), the server application (OpenSSH, VNC, etc), and the special configuration (Kiosk system, etc) to installation process with a few commands.
Configuration is managable as a component.
So we can use the components which you need, when you need them!

## User Guides

### Work with Interactive Shell

You can try the next commands __in Bash__ to install the new system with the preset named `basic`:

```bash
eval "$(curl https://raw.githubusercontent.com/sakkke/afw/main/afw)"
afw presets/basic
```

You can see available presets in [/components/presets/](https://github.com/sakkke/afw/tree/main/components/presets).
Or, you can see [how to create the your custom preset](#create-the-your-custom-preset).

### Work with Script

Add the next one-liner to your script:

```bash
eval "$(curl https://raw.githubusercontent.com/sakkke/afw/main/afw)"
```

<details>
<summary>The next code is the example script</summary>

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

# Prompt for device which will be installed on the new system
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

</details>

## Development Guides

afw is Bash function; it does two steps:

1. Download the script from the entry point URL with cURL
2. Eval the downloaded script content in the current shell

The default entry point URL is `https://raw.githubusercontent.com/sakkke/afw/main/components`.
You can change the entry point URL with the environment variable `AFW_ENTRYPOINT`.

### Directory Structure

- `components/`: Entry point
  - `deps/`: Including scripts of dependencies
    - `presets/`: Dependencies for presets
    - `[-A-Z_a-z]+/`: Including scripts
    - `[-A-Z_a-z]+`: Scripts
  - `presets/`: Including scripts for users
  - `prompts/`: Including scripts for inputting
  - `vars/`: Including scripts of variables
    - `presets/`: Variables for presets
    - `[-A-Z_a-z]+/`: Including scripts
    - `[-A-Z_a-z]+`: Scripts
  - `[-A-Z_a-z]+/`: Including scripts
  - `[-A-Z_a-z]+`: Scripts

### Script Naming Rules

Scripts are named `<noun>`, `<command_name>` or `<verb>-<noun>`.

### Create the your custom preset

#### A Recommended Way

First, create the script in `$AFW_ENTRYPOINT/presets/`.
Here, name the script as `foo`.
Put the next content to newly created script:

```bash
#!/bin/bash

afw vars/foo
afw deps/foo
afw done
```

This script does three steps:

1. Load variables
2. Load dependencies
3. Show the done messages

Second, enter Bash.
To run newly created script:

```bash
afw presets/foo
```

## License

`MIT`
