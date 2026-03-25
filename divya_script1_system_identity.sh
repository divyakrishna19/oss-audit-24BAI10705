#!/bin/bash
# =============================================================
# Script 1: System Identity Report
# Author: Divya Krishna | Reg No: 24BAI10705 | Slot: A11 | Date: 26 March 2026
# Course: Open Source Software (CSE0002) | VIT Bhopal
# Chosen Software: Linux Kernel
# Description: Displays a welcome screen with system info and
#              open-source license details of the running OS.
# =============================================================

# --- Student Variables (fill these in before submission) ---
STUDENT_NAME="Divya Krishna"
REG_NUMBER="24BAI10705"
SOFTWARE_CHOICE="Git"

# --- Gather system information using command substitution ---
KERNEL=$(uname -r)                        # Kernel version
ARCH=$(uname -m)                          # CPU architecture
USER_NAME=$(whoami)                       # Current logged-in user
HOME_DIR=$HOME                            # User's home directory
UPTIME=$(uptime -p)                       # Human-readable uptime
CURRENT_DATE=$(date '+%d %B %Y')          # Formatted date
CURRENT_TIME=$(date '+%H:%M:%S')          # Current time

# --- Get distro name from /etc/os-release (standard on all modern Linux) ---
DISTRO=$(grep '^PRETTY_NAME' /etc/os-release | cut -d= -f2 | tr -d '"')

# --- The Linux kernel is licensed under GPL v2 ---
KERNEL_LICENSE="GNU General Public License version 2 (GPL v2)"

# --- Display the report ---
echo "================================================================"
echo "       OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT"
echo "================================================================"
echo "  Student  : $STUDENT_NAME ($REG_NUMBER)"
echo "  Software : $SOFTWARE_CHOICE"
echo "================================================================"
echo ""
echo "  SYSTEM INFORMATION"
echo "  ------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Architecture : $ARCH"
echo ""
echo "  USER INFORMATION"
echo "  ----------------"
echo "  Logged-in as : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo ""
echo "  UPTIME & TIME"
echo "  -------------"
echo "  System Uptime : $UPTIME"
echo "  Date          : $CURRENT_DATE"
echo "  Time          : $CURRENT_TIME"
echo ""
echo "  LICENSE INFORMATION"
echo "  -------------------"
echo "  The Linux kernel is licensed under:"
echo "  $KERNEL_LICENSE"
echo ""
echo "  This means you have the freedom to:"
echo "    [1] Run the kernel for any purpose"
echo "    [2] Study and modify the source code"
echo "    [3] Distribute copies to others"
echo "    [4] Distribute your modified versions"
echo "================================================================"
echo "  End of System Identity Report"
echo "================================================================"
