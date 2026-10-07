#!/bin/sh
p=$(cat /sys/firmware/acpi/platform_profile)
case $p in
  performance) icon="🚀" ;;
  balanced)    icon="⚖" ;;
  low-power)   icon="🍃" ;;
  *)           icon="?" ;;
esac
printf '{"text":"%s","class":"%s","tooltip":"Power profile: %s"}\n' "$icon" "$p" "$p"
