#!/usr/bin/env bash


if [ "$@" ]; then
	hyprctl keyword monitor "$@, disable"
	exit 0
elif [[ "$@" = x"reload" ]]; then
	hyprctl reload
	exit 0
fi

echo -en "\0prompt\x1fDisable Monitor\n"

echo "Monitor eDP-1 (ID 0):" | grep -Po '(?<=Monitor )[^ ]+(?= \(ID \d+\))'
echo "reload"

