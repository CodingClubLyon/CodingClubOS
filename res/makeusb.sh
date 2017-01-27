#!/bin/bash

errhand() {
    if [ "$1" != "0" ]; then
	printf "Failed.\n"
	exit 2
    fi
    if [ -z "$2" ]; then
	printf "Success.\n"
    fi
}

# User input errors
if [ -z "$1" ] || [ ! -b "$1" ]; then
    echo "Usage: $0 <target device>" >&2
    exit 1
elif [ "$USER" != "root" ]; then
    echo "Root privileges required." >&2
    exit 1
fi

printf "Generating a mountpoint... "
mountpoint=$(mktemp -d --tmpdir "ccos-mkusb.XXXXXXXXXX" 2> /dev/null)
errhand "$?"

printf "Temporary mountpoint: %s\n\n" "$mountpoint"
printf "Writing default SYSLINUX MBR to device... "
dd if=/usr/lib/syslinux/mbr/mbr.bin of=$1 > /dev/null 2>&1
errhand "$?"

printf "Creating new filesystem on %s1... " "$1"
mkfs.ext3 -F "${1}1" > /dev/null 2>&1
errhand "$?"

printf "Mounting device on %s... " "$mountpoint"
mount "${1}1" $mountpoint > /dev/null 2>&1
errhand "$?"

printf "Installing SYSLINUX... "
mkdir -p $mountpoint/boot/extlinux $mountpoint/live > /dev/null 2>&1
errhand "$?" next

extlinux -i $mountpoint/boot/extlinux > /dev/null 2>&1
errhand "$?" next

cp image/extlinux.conf $mountpoint/boot/extlinux/extlinux.conf > /dev/null 2>&1
errhand "$?"

printf "Deploying kernel... "
cp image/vmlinuz $mountpoint/boot/vmlinuz > /dev/null 2>&1
errhand "$?"

printf "Deploying initial ramdisk... "
cp image/initrd $mountpoint/boot/initrd > /dev/null 2>&1
errhand "$?"

printf "Copying SquashFS image... "
cp image/filesystem.squashfs $mountpoint/live/filesystem.squashfs > /dev/null 2>&1
errhand "$?"

printf "Copying MANIFEST file... "
cp image/manifest $mountpoint/manifest > /dev/null 2>&1
errhand "$?"

printf "Unmounting drive... "
umount $mountpoint > /dev/null 2>&1
errhand "$?"

printf "Cleaning up... "
rmdir $mountpoint > /dev/null 2>&1
errhand "$?"

printf "Done, you can now unplug the device.\n"
