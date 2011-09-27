#!/bin/bash
# http://habrahabr.ru/blogs/linux/115451/
case $1 in
    save)
        echo 5 > /proc/sys/vm/laptop_mode
        for i in $(ls /sys/class/scsi_host); do
            echo min_power > /sys/class/scsi_host/$i/link_power_management_policy
        done
        echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
        echo powersave > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo 1 > /sys/devices/system/cpu/sched_mc_power_savings
        echo 90 > /proc/sys/vm/dirty_ratio
        echo 1 > /proc/sys/vm/dirty_background_ratio
        echo 60000 > /proc/sys/vm/dirty_writeback_centisecs
        echo powersave > /sys/module/pcie_aspm/parameters/policy
        echo "4" > /sys/class/backlight/acpi_video0/brightness
        ;;
    performance)
        echo 0 > /proc/sys/vm/laptop_mode
        for i in $(ls /sys/class/scsi_host); do
            echo max_performance > /sys/class/scsi_host/$i/link_power_management_policy
        done
        echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor  
        echo ondemand > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo 0 > /sys/devices/system/cpu/sched_mc_power_savings
        echo 10 > /proc/sys/vm/dirty_ratio 
        echo 5 > /proc/sys/vm/dirty_background_ratio
        echo 6000 > /proc/sys/vm/dirty_writeback_centisecs
        echo default > /sys/module/pcie_aspm/parameters/policy
        echo "8" > /sys/class/backlight/acpi_video0/brightness
        ;;
    *)
        echo "Sorry, I don't understand"
        ;;
esac
