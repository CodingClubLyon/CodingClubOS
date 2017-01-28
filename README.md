CodingClubOS for Epitech Lyon
=============================
Description
-----------
CodingClubOS is a portable Xubuntu-based distribution, created for Epitech Lyon's Coding Club. The system comes with all the necessary tools to discover how to code during a coding club.

In this repository you will find some tools and useful information to create a new CodingClubOS live media.

Feel free to report any issues encountered or any suggestion through Github's bug-tracker.

Download CodingClubOS
---------------------
Due to Github's file size limitation, CodingClubOS can't be hosted directly on this repository.

You can download the latest version [here](https://bigsufi.vparres.ovh/fs/CodingClubOS).

Use makeusb.sh to create a live media
-------------------------------------
### Prerequisites :
* Any Linux distribution (macOS might be compatible)
* `coreutils`
* `e2fsprogs`
* `syslinux`
* A target media of at least 2GB

*Usage :*
* Plug in your media, and find the block device corresponding to it in the `/dev` FS.
* Make a folder named `image` next to `makeusb.sh` location, and make sure it contains `vmlinuz`, `initrd`, `extlinux.conf`, `filesystem.squashfs` and `manifest` files that you downloaded before.
* Launch `makeusb.sh` as root, passing it the block path as first argument.
* Test your device by booting it on a computer, in legacy BIOS/CSM mode.

Evolution
---------
CodingClubOS is still at a beta stage, and improvements will be done, here is a list of some planned changes:
* UEFI Boot support
* Auto-Updating
* Persistent installations
* New background

Feel free to make any suggestions :-)