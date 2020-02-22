#!/bin/bash

shopt -s lastpipe

rofistr=$(udiskie-info -a -o "{device_file};{drive_label};{ui_id_uuid};{is_mounted};{mount_path}" | {
	      while IFS=';' read dev drive part is_mnt mnt
	      do
		  [ "$is_mnt" = "True" ] &&
		      mnt="mounted at $mnt" ||
			  mnt="not mounted"
		  echo "${dev} ${drive}${part} ($mnt)\n"
	      done; })
ans=$(echo -en $rofistr | rofi -dmenu -theme android_notification)

mounted=$(echo $ans | cut -d'(' -f2)
dev=$(echo $ans | cut -d' ' -f1)
[ "$mounted" = "not mounted)" ] &&
    udiskie-mount ${dev} ||
	udiskie-umount ${dev}
