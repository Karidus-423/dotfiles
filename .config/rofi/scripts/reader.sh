#!/usr/bin/env bash

ROFI_FB_GENERIC_FO="xdg-open"

selected=$(find ~/notes/Resources -type f)

if [ "$@" ]; then
	file_path=$(find ~/notes/Resources -type f -name $@)
	coproc ( "${ROFI_FB_GENERIC_FO}" "$file_path" >/dev/null 2>&1 )
	exit 0
fi

echo -e "$selected" | while IFS= read -r file; do
	file_name=$(basename "$file") 
    echo "$file_name"
done


