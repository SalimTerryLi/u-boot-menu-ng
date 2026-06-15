---
title: U-BOOT-UPDATE
section: 8
header: System Manager's Manual
#footer: u-boot-menu-ng $version$
date: June 2026
---

# NAME

u-boot-update - update boot entry configuration for uboot

# SYNOPSIS

**u-boot-update**

# DESCRIPTION

**u-boot-update** is used to create `/boot/extlinux/extlinux.conf` loadable by U-Boot.

It is usually called from kernel service scripts like `kernel-install` to automatically update the configuration when the kernel packages are changed (e.g. installed, removed, reinstalled). User may just invoke it directly as well.

It will load configuration from the following places in order:

- `/usr/share/u-boot-menu/conf.d/*.conf` : System-level configuration preinstalled by distro
- `/etc/default/u-boot` : Editable file for sysadmin

Option loaded later will override existing value.

Two types of plugins are supported:

- finder plugin: Searchs for bootable kernel image.
- target plugin: Post-configuring boot entries for different behaviors.

Integrations are provided for different deployments:

## Systemd kernel-install

`90-u-boot-menu.install` will perform copying of kernel image, initrd and dtbs (if exist) to `/boot` and then call `u-boot-update`.

`KERNEL_INSTALL_LAYOUT` must be set to `u-boot`.

# ENVIRONMENT

## CONFIG_FILE_PATH

If provided with non-empty value, its value will be used as path to sysadmin configuration file. Defaults to `/etc/default/u-boot`

## CONFIG_DIR_PATH

If provided with non-empty value, its value will be used as path to preinstalled configuration directory. Defaults to `/usr/share/u-boot-menu/conf.d`

## PLUGIN_SYS_PATH

If provided with non-empty value, its value will be used as path to preinstalled plugins. Defaults to `/usr/share/u-boot-menu/plugins`

## PLUGIN_USER_PATH

If provided with non-empty value, its value will be used as path to sysadmin crafted plugins. Plugins in `PLUGIN_USER_PATH` will replace ones in `PLUGIN_SYS_PATH` with the same name. Defaults to `/etc/u-boot-menu/plugins`

## LOG_LEVEL

Defaults to `ERROR`. Choose one from `DEBUG`, `INFO`, `WARN`, `ERROR`, `NONE`.

# COMPATIBILITY

This version of `u-boot-update` is not compatible with original one made for Debian.

# SEE ALSO

`kernel-install`(8), `u-boot-menu-ng.conf`(5)
