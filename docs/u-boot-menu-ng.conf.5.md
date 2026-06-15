---
title: U-BOOT-MENU.CONF
section: 5
header: System Manager's Manual
#footer: u-boot-menu-ng $version$
date: June 2026
---

# NAME

`u-boot-menu.conf` - configuration of u-boot-menu-ng

# SYNOPSIS

`/etc/default/u-boot`

# DESCRIPTION

Those files are actually POSIX-complaint shell scripts, but they should never be directly executed. They works by setting variables and then picked up by `u-boot-update` later.

The config file will be evaluated twice:

- First time the whole file is sourced by `u-boot-update` during configuration parsing.
- Then the value of each configuration item may be re-evaluated in order to inject contexts.

That means proper escaping is required to make it work. Usually the content of configuration item should be wrapped in '' to keep it as is, unless it is intended to perform any variable expansion during configuration parsing stage.

The different configuration options are:

## U_BOOT_CONFIG_PATH

Where to write the generated extlinux.conf.

Defaults to `'/boot/extlinux/extlinux.conf'`.

## U_BOOT_TIMEOUT

U-Boot will wait such amount of time then choose default entry to boot, if no user intervention happens, in 1/10s.

Defaults to 50, which is 5s.

Setting to 0 will disable the countdown entirely.

## U_BOOT_PROMPT

Always prompt user input if non-zero, otherwise prompts only if timeout is interrupted by user.

Defaults to 1.

## U_BOOT_TITLE

Title of the boot menu.

## U_BOOT_SEARCH_METHOD

Configure how to discover the bootable kernel entries. Built-in methods:

- `bootdir` : Searching in `/boot` by default.
- `modulesdir` : Searching in `/lib/modules` by default.

Can be extended by finder plugins.

## U_BOOT_METH_BOOTDIR_PATH

When U_BOOT_SEARCH_METHOD=bootdir, this options controls where to search for kernel images.

Defaults to `'/boot'`

## U_BOOT_METH_BOOTDIR_PATTERN

When U_BOOT_SEARCH_METHOD=bootdir, this options controls the matching pattern of kernel image filename, in extended regex format.

The first capture group should matching everything before kernel version; then follows the kernel version; and remainings.

Defaults to `'^(vmlinuz-)(.+)()$'`

## U_BOOT_METH_MODULESDIR_KERNELNAME

When U_BOOT_SEARCH_METHOD=modulesdir, this options set the filename of kernel image.

Whole directory is skipped if kernel image file doesnot exist.

## U_BOOT_TARGETS

Configures enabled boot targets per kernel image. Separated by space. Built-in options:

- `default`
- `rescue` : Appending `single` to kernel cmdline.

Can be extended by target plugins.

## U_BOOT_ENTRIES_NUM

Maximum number of kernel entries to be included into boot menu.

Defaults to 5.

## U_BOOT_ENTRY_LABEL

Label of each boot entry.

Defaults to `'Bootable - Linux${KERNEL_VERSION:+ ${KERNEL_VERSION}}${BOOT_TARGET:+ (${BOOT_TARGET})}'`

`KERNEL_VERSION`, `BOOT_TARGET` will be injected when bootmenu is being generated, which is the second pass of variable expansion.

## U_BOOT_ENTRY_KERNEL

Kernel image filename that is seen by U-Boot.

Defaults to `'/boot/vmlinuz${KERNEL_VERSION:+-${KERNEL_VERSION}}'`

Note the file existence is not checked when configuration is generated.

## U_BOOT_ENTRY_BOOT_ARGS

Boot args passed to kernel.

Defaults to `'root="$(findmnt -nfo SOURCE /)"'`

`root=` options should be specified here.

## U_BOOT_ENTRY_INITRD

initrd/initramfs filename that is seen by U-Boot.

Defaults to `'/boot/initramfs${KERNEL_VERSION:+-${KERNEL_VERSION}}.img'`

Note the file existence is not checked when configuration is generated.

## U_BOOT_ENTRY_FDT

DTB filename that is seen by U-Boot.

Defaults to `''`

Note the file existence is not checked when configuration is generated.

## U_BOOT_ENTRY_FDT_DIR

Base directory that contains dtbs for auto-select, seen by U-Boot.

Defaults to `'/boot/dtb-${KERNEL_VERSION}'`

Only effective if U_BOOT_ENTRY_FDT is empty. Don't forget to set it to `''` if dtb is not intended to be reloaded during boot.

# FILES

`/etc/default/u-boot`, `/usr/share/u-boot-menu/conf.d/*.conf`

# SEE ALSO

`u-boot-update`(8)
