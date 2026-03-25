#!/bin/bash
# =============================================================
# Script 4: Log File Analyzer
# Author: Divya Krishna | Reg No: 24BAI10705 | Slot: A11 | Date: 26 March 2026
# Course: Open Source Software (CSE0002) | VIT Bhopal
# Chosen Software: Linux Kernel
# Description: Reads a log file line by line, counts keyword
#              occurrences, and prints matching lines.
#              Demonstrates while-read loop, counters, args.
# Usage: ./script4_log_analyzer.sh [logfile] [keyword]
#   e.g: ./script4_log_analyzer.sh /var/log/syslog kernel
#   e.g: ./script4_log_analyzer.sh /var/log/kern.log error
# =============================================================

# --- Accept command-line arguments ---
LOGFILE=${1:-/var/log/syslog}      # Default: syslog (kernel messages appear here)
KEYWORD=${2:-"kernel"}             # Default keyword for Linux Kernel audit

# --- Counter variables initialised to zero ---
COUNT=0
LINE_NUM=0

# --- Array to store matching lines for later display ---
MATCHING_LINES=()

echo "================================================================"
echo "         LOG FILE ANALYZER"
echo "         Linux Kernel Audit — Log Report"
echo "================================================================"
echo "  Log File  : $LOGFILE"
echo "  Keyword   : '$KEYWORD' (case-insensitive)"
echo "----------------------------------------------------------------"

# --- Check if log file exists before processing ---
if [ ! -f "$LOGFILE" ]; then
    echo ""
    echo "  ERROR: Log file '$LOGFILE' not found."
    echo ""

    # Try fallback log files common on Ubuntu systems
    echo "  Trying fallback log files..."
    FALLBACKS=("/var/log/kern.log" "/var/log/dmesg" "/var/log/boot.log")

    for FB in "${FALLBACKS[@]}"; do
        if [ -f "$FB" ]; then
            echo "  Found fallback: $FB — using this instead."
            LOGFILE="$FB"
            break
        fi
    done

    # If still not found, exit with an error
    if [ ! -f "$LOGFILE" ]; then
        echo "  No readable log file found. Try: sudo ./script4_log_analyzer.sh /var/log/syslog"
        exit 1
    fi
fi

# --- Check if the file is empty ---
if [ ! -s "$LOGFILE" ]; then
    echo "  WARNING: Log file is empty."
    echo "  Tip: Run 'dmesg > /tmp/kernel_dmesg.log' and retry with that file."
    exit 0
fi

echo "  Scanning log file — please wait..."
echo ""

# --- while read loop: process the file line by line ---
while IFS= read -r LINE; do
    LINE_NUM=$((LINE_NUM + 1))   # Increment total line counter

    # --- if-then: check if the current line contains the keyword (case-insensitive) ---
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))                  # Increment match counter
        MATCHING_LINES+=("$LINE")             # Store the matching line
    fi

done < "$LOGFILE"    # Redirect file as input to the while loop

# --- Display summary ---
echo "----------------------------------------------------------------"
echo "  SCAN SUMMARY"
echo "----------------------------------------------------------------"
echo "  Total lines scanned  : $LINE_NUM"
echo "  Keyword matches found: $COUNT"
echo ""

# --- Show the last 5 matching lines if any were found ---
if [ "$COUNT" -gt 0 ]; then
    echo "  LAST 5 MATCHING LINES:"
    echo "  ----------------------"

    # Calculate start index to show only last 5
    TOTAL=${#MATCHING_LINES[@]}
    START=$(( TOTAL > 5 ? TOTAL - 5 : 0 ))

    # Loop from START to end of the array
    for (( i=START; i<TOTAL; i++ )); do
        # Truncate long lines to 100 chars for readability
        echo "  > ${MATCHING_LINES[$i]:0:100}"
    done
else
    echo "  No lines matching '$KEYWORD' were found in $LOGFILE."
    echo "  Try a different keyword, e.g.: error, warn, usb, eth, cpu"
fi

echo ""
echo "================================================================"
echo "  KERNEL LOG INSIGHT"
echo "================================================================"
echo ""
echo "  The Linux kernel logs everything to syslog/kern.log."
echo "  This transparency is a direct product of open source:"
echo "  you can see exactly what your OS is doing, when, and why."
echo "  Proprietary OS logs are often encrypted or hidden from users."
echo ""
echo "  Try: ./script4_log_analyzer.sh /var/log/kern.log error"
echo "  Or:  dmesg | grep -i usb  (kernel ring buffer)"
echo "================================================================"
