#!/bin/bash
# enable dbus

sudo mkdir -p /var/run/dbus
sudo dbus-uuidgen > /var/lib/dbus/machine-id
sudo dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address


# add root
sudo adduser root pulse-access
sudo adduser root audio

# Cleanup to be "stateless" on startup, otherwise pulseaudio daemon can't start

sudo rm -rf /var/run/pulse /var/lib/pulse /root/.config/pulse
cp /etc/pulse/* ~/.config/pulse/

pulseaudio -D --exit-idle-time=-1

# Create a virtual speaker output

pactl load-module module-null-sink sink_name=SpeakerOutput
pactl set-default-sink SpeakerOutput
pactl set-default-source SpeakerOutput.monitor

#make config file
mkdir ~/.config
echo -e "[General]\nsystem.audio.type=default" > ~/.config/zoomus.conf

