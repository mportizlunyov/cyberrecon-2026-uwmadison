#!/bin/bash

# CyberRECon 2026 UW-Madison
# Developed by Mikhail Ortiz-Lunyov
# February 2026
#
# Setup script to set up network monitoring on LAN
#  via Monitor Mode and WireShark
#
# Will use Monitoring Mode on `wlan0`,
#  therefore ssh into Pi via `eth0`
#
# Confirm your sandbox allows file writing!

# https://www.kali.org/blog/raspberry-pi-wi-fi-glow-up/
# This script will install the following:
# - Wireshark (twireshark)
# - Aircrack-ng


echo "Make sure you are connected via eth0!"


# Kali Linux on RAspbery Pi does NOT enable ssh by default (add file `ssh`` in boot folder)

# Update packages
sudo apt update
# sudo apt full-upgrade -y
# Confirm `wireshark`, `tshark`, `aircrack-ng` are installed
sudo apt install wireshark tshark aircrack-ng -y

# Set wlan0 down and up
sudo ip link set wlan0 down
sudo iw dev wlan0 set type monitor
sudo ip link wlan0 up