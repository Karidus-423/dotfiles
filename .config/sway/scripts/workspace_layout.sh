#!/bin/zsh

screen_width=$(swaymsg -t get_outputs | jq '.[0].rect.width')
screen_height=$(swaymsg -t get_outputs | jq '.[0].rect.height')

if ["$screen_width" -lt 3440 && "$screen_height" -lt 1440]; then
    smart_gaps inverse_outer
    gaps inner 10
    gaps horizontal 40
    gaps vertical 100
else ["$screen_width" -lt 1336 && "$screen_height" -lt 768]; then
    gap_size=10
fi



