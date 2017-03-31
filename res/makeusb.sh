#!/bin/bash
SOURCE_DIRECTORY=versions/1.1.0

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

printf "Initializing partition scheme... "
sgdisk -Z -N 1 -t 1:ef00 -A 1:set:0 -A 1:set:2 -c "EFI System Partition" "$1" > /dev/null 2>&1
errhand "$?"

printf "Writing GPT SYSLINUX MBR to device... "
dd bs=440 conv=notrunc count=1 if=/usr/lib/syslinux/mbr/gptmbr.bin of=$1 > /dev/null 2>&1
errhand "$?"

printf "Formatting %s1 as FAT32... " "$1"
mkfs.fat -F 32 "${1}1" > /dev/null 2>&1
errhand "$?"

printf "Generating a mountpoint... "
mountpoint=$(mktemp -d --tmpdir "ccos-mkusb.XXXXXXXXXX" 2> /dev/null)
errhand "$?"
printf "Temporary mountpoint: %s\n\n" "$mountpoint"

printf "Mounting device %s1 on %s... " "$1" "$mountpoint"
mount "${1}1" $mountpoint > /dev/null 2>&1
errhand "$?"

printf "Installing SYSLINUX... "
mkdir -p $mountpoint/boot/syslinux > /dev/null 2>&1
errhand "$?" next

extlinux -i $mountpoint/boot/syslinux > /dev/null 2>&1
errhand "$?" next

cp /usr/lib/syslinux/modules/bios/*.c32 $mountpoint/boot/syslinux
errhand "$?"

printf "Installing systemd-boot... "
bootctl --no-variables --path=$mountpoint install > /dev/null 2>&1
errhand "$?"

printf "Copying files...\n"
cp -rv $SOURCE_DIRECTORY/* $mountpoint 2> /dev/null
# NOTE: This does NOT work. Well it does, but it's buffered, so that removes the whole point of it.
# | sed -ru "s/'(.+)' \-> '.+'/\1/g"
errhand "$?"

printf "Unmounting drive... "
umount $mountpoint > /dev/null 2>&1
errhand "$?"

printf "Cleaning up... "
sleep 2
rm -rf $mountpoint > /dev/null 2>&1
errhand "$?"

printf "\nDone, you can now unplug the device.\n"
