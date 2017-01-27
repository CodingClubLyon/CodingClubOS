CodingClubOS for Epitech Lyon
=============================
Description
-----------
CodingClubOS is a portable XUbuntu based distribution, created for Epitech Lyon's Coding Club. The system come with all the necessary tools to dicover how to code during a coding club.
In this repo you will find some tools and useful informations to create a new CodingOS live media.
Feel free to report any issues occured or any suggestion throught the Github's report system.

Download CodingClubOS
---------------------
Due to the Github's file size limitation, CodingClubOS can't be hosted directely to Github.
You can download the latest version [here](https://bigsufi.vparres.ovh/fs/CodingClubOS).

Use makeusb.sh to create a live media
-------------------------------------
*Prerequisites :*
* Any Linux Distro (Maybe macOS might be compatible)
* `coreutils`
* `e2fsprogs`
* `syslinux`
* A 2GB or more USB Flash Drive

*Usage :*
* Plug in your Flash Drive, and find the block device corresponding to the target media.
* Make a folder named "image" containing `vmlinuz, initrd, extlinux.conf, filesystem.squashfs and manifest` that you downloaded before.
* Launch `makeusb.sh` like this :```sudo ./makeusb.sh <target media block device>```
* Test your device by booting it on a computer (In legacy mode).

Evolution
---------
CodingOS still in a beta stage, and some improvements will be done, here is a list of some upcoming evolutions :
* UEFI Boot support.
* Auto-Update Script.
* Hard Drive installation.
* New background.
Feel free to suggest any evolution :-)