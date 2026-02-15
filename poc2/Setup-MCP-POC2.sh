#!/bin/bash

# CyberRECon 2026 UW-Madison
# Developed by Mikhail Ortiz-Lunyov
# February 2026
#
# Setup script to create Proof-of-Concept #2
# Assuming Linux (tested on Fedora 43 Server)
#
# Confirm your sandbox allows file writing!

# This script will install the following:
# - FastMCP (Python) v2

if [[ "$1" == "-h" || "$1" == "--help" ]] ; then
    echo "Use \` --unrestricted \` for running unrestricted MCP server"
    echo "Use \` --fullshellinsecure \` for running full-shelled MCP server"
    exit 1
fi

echo "== VERIFYING PACKAGES == == == =="
# Confirm existance of python3
python3 --version > /dev/null
if [ $? == 127 ] ; then
    echo "Python3 is NOT installed"
    exit 1
fi

# Install default FastMCP if not installed
sudo dnf install python3-pip
if [ $? == 127 ] ; then
    echo "PIP install failed"
    exit 1
fi

echo "== SETTING UP FastMCP Python == == == =="
if [ "$1" == "--fullshellinsecure" ] ; then
    python3 ./../server.py 4
elif [ "$1" == "--unrestricted" ] ; then
    python3 ./..server.py 3
else
    python3 ./../server.py 2
fi