#!/bin/bash

# device=$(udiskie-info -2 -a -o "{ui_label} {mount_path}" | rofi -dmenu -theme android_notification)

export rofistr=""
rofistr=$(udiskie-info -2 -a -o "{ui_label} {mount_path}" | \
	      while read dev name mnt
	      do
		  echo -n "${dev} ${name}"
		  [ ! -z "${mnt}" ] && echo -n " (mounted at ${mnt})" || echo -n " (not mounted)"
		  echo
	      done)
device=$(echo $rofistr | rofi -dmenu -theme android_notification)

[ -z "$device" ] || {
    dev=$(echo $device | cut -d' ' -f1);
    mnt=$(echo $device | cut -d' ' -f3);
    dev=${dev%%:}
    echo $dev aaa $mnt;
    [ -z "$mnt" ] && udisksctl mount -b ${dev} || udisksctl unmount -b ${dev} ; \
}
