#!/bin/sh
p=$(cat /sys/firmware/acpi/platform_profile)
# Nerd Font glyphs from the bar font (nf-md-rocket_launch U+F14DE,
# nf-md-scale_balance U+F05D1, nf-md-leaf U+F032A); colours per class in style.css.
case $p in
  performance) icon="󱓞" ;;
  balanced)    icon="󰗑" ;;
  low-power)   icon="󰌪" ;;
  *)           icon="?" ;;
esac
printf '{"text":"%s","class":"%s","tooltip":"Power profile: %s"}\n' "$icon" "$p" "$p"
