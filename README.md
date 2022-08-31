<div align="center">

# afw

Arch Framework which helps to install the new Arch Linux ⚙️

Repo

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?logo=archlinux&logoColor=FFF&style=flat-square)](https://archlinux.org/)
[![GitHub forks](https://img.shields.io/github/forks/sakkke/afw?style=flat-square)](https://github.com/sakkke/afw/fork)
[![GitHub issues](https://img.shields.io/github/issues/sakkke/afw?style=flat-square)](https://github.com/sakkke/afw/issues)
[![GitHub license](https://img.shields.io/github/license/sakkke/afw?style=flat-square)](https://github.com/sakkke/afw/blob/main/LICENSE)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/sakkke/afw?style=flat-square)](https://github.com/sakkke/afw/pulls)
[![GitHub stars](https://img.shields.io/github/stars/sakkke/afw?style=flat-square)](https://github.com/sakkke/afw/stargazers)

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

Dev

[![Codecov](https://img.shields.io/codecov/c/github/sakkke/afw?style=flat-square)](https://app.codecov.io/gh/sakkke/afw)
[![Super-Linter Status](https://img.shields.io/github/workflow/status/sakkke/afw/Lint%20Code%20Base?label=Super-Linter&logo=githubactions&logoColor=fff&style=flat-square)](https://github.com/sakkke/afw/actions/workflows/linter.yml)

Communities

[![Discord](https://img.shields.io/discord/1012345440873742436?color=5865F2&label=Discord&logo=discord&logoColor=FFF&style=flat-square)](https://discord.gg/HYKfDBMkyq)
[![IRC](https://img.shields.io/badge/IRC-%23afw-blue?style=flat-square)](https://web.libera.chat/)

Donation

[![Buy Me A Pizza](https://img.shields.io/badge/Buy_Me_A_Pizza-FFDD00?logo=buymeacoffee&logoColor=000&style=flat-square)](https://www.buymeacoffee.com/sakkke)

__ATTENTION ME!__

This is very early stage project.
So it may happen some breaking changes.

</div>

---

[![asciicast](https://asciinema.org/a/517447.svg)](https://asciinema.org/a/517447)

## Overview

It's Arch Framework which helps to install the new Arch Linux.
afw is made with Bash and available in [interactive shell](#work-with-interactive-shell) and [script](#work-with-script).

### Good Points

- Simple structure
- Easy installation of Arch Linux
- Highly customizable
- Custom entry point support

We can add the desktop environment (GNOME, KDE, etc), the server application (OpenSSH, VNC, etc), and the special configuration (Kiosk system, etc) to installation process with a few commands.
Configuration is managable as a component.
So we can use the components which you need, when you need them!

## Philosophy

> Be Simple

> Done is Better Than Perfect

They continue to maintain [good points](#good-points).
They are also useful for helping developers.

## User Guides

### Work with Interactive Shell

You can try the next commands __in Bash__ to install the new system with the preset named `basic`:

```bash
eval "$(curl https://raw.githubusercontent.com/sakkke/afw/main/src/afw)"
afw presets/basic
```

You can see available presets in [/components/presets/](https://github.com/sakkke/afw/tree/main/components/presets).
Or, you can see [how to create the your custom preset](#create-the-your-custom-preset).

### Work with Script

Add the next one-liner to your script:

```bash
eval "$(curl https://raw.githubusercontent.com/sakkke/afw/main/src/afw)"
```

<details>
<summary>The next code is the example script</summary>

```bash
#!/bin/bash

eval "$(curl https://raw.githubusercontent.com/sakkke/afw/main/src/afw)"

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

### Environment Variables

There are environment variables which is used by afw function.

Name | Description | Default value
--- | --- | ---
`AFW_ENTRYPOINT` | URL or file path to reference the components directory. | `https://raw.githubusercontent.com/sakkke/afw/main/components`

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

`#!/bin/bash` tells the editor the file type.
This script does three steps:

1. Load variables
2. Load dependencies
3. Show the done messages

Second, enter Bash.
To run newly created script:

```bash
afw presets/foo
```

## Code of Conduct

See [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md).

## Contributing

Feel free to contribute to this project!
There is [CONTRIBUTING.md](./CONTRIBUTING.md).

## License

`MIT`

There is [LICENSE](./LICENSE).

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/sakkke"><img src="https://avatars.githubusercontent.com/u/84666033?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Konosuke Sakai</b></sub></a><br /><a href="https://github.com/sakkke/afw/commits?author=sakkke" title="Code">💻</a> <a href="https://github.com/sakkke/afw/commits?author=sakkke" title="Documentation">📖</a> <a href="#ideas-sakkke" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://www.linkedin.com/in/taylorjeandev/"><img src="https://avatars.githubusercontent.com/u/98131909?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Taylor Jean</b></sub></a><br /><a href="https://github.com/sakkke/afw/commits?author=taylorjeandev" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!