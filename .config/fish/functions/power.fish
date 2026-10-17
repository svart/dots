function power --description 'Show or switch the ACPI platform power profile'
    set -l profile_file /sys/firmware/acpi/platform_profile
    switch "$argv[1]"
        case performance perf
            if test (cat /sys/class/power_supply/AC*/online)[1] != 1
                echo "power: on battery, refusing performance" >&2
                return 1
            end
            echo performance | sudo tee $profile_file >/dev/null; or return
        case balanced bal
            # Re-apply the TLP config: balanced on AC, power-saver on battery.
            sudo tlp start >/dev/null; or return
        case fullcharge
            # Charge to 100% once; TLP restores the thresholds when AC is unplugged.
            sudo tlp fullcharge BAT0
            return
        case '' status
        case '*'
            echo "usage: power [performance|balanced|fullcharge|status]" >&2
            return 2
    end
    # Refresh the waybar module now instead of waiting for its 10 s interval.
    pkill -SIGRTMIN+8 -x waybar
    set -l cpu /sys/devices/system/cpu/cpu0/cpufreq
    echo (cat $profile_file)", governor "(cat $cpu/scaling_governor)", EPP "(cat $cpu/energy_performance_preference)
end
