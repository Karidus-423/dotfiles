#!/usr/bin/env bash

ROFI_FB_GENERIC_FO="xdg-open"

selected=$(find ~/notes/Resources -type f)

if [ "$@" ]; then
	coproc ( "${ROFI_FB_GENERIC_FO}" "$@" >/dev/null 2>&1 )
	exit 0
fi

echo -e "$selected" | while IFS= read -r file; do
    echo "$file"
done


