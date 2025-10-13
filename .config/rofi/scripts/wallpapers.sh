#!/usr/bin/env bash

wallpapers=$(find ~/Pictures/Wallpapers -type f)

if [ "$@" ]; then
	file_path=$(find ~/Pictures/Wallpapers -type f -name $@)
	coproc ( "$(swww img $file_path -t random --transition-bezier 0.4,0.83,0.32,0.97 --transition-fps 60)" >/dev/null 2>&1 )
	exit 0
fi

echo -e "$wallpapers" | while IFS= read -r wallpaper; do
	name=$(basename "$wallpaper") 
    echo "$name"
done


