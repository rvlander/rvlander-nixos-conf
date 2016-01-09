#!/bin/sh
# Read the status of the relevant graphics adapter
echo `date` >> /root/monitor.log
read STATUS < /sys/class/drm/card0-HDMI-A-1/status
export DISPLAY=:0
export XAUTHORITY=/home/gandre/.Xauthority
if [ "$STATUS" = "connected" ]; then
  echo con >> /root/monitor.log
  /run/current-system/sw/bin/xrandr --output HDMI1 --right-of eDP1 --auto --screen 0 &>>/root/monitor.log
else
  echo dis >> /root/monitor.log
  /run/current-system/sw/bin/xrandr --output HDMI1 --off --screen 0 &>>/root/monitor.log
fi
