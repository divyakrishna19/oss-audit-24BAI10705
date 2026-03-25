#!/bin/bash
# =============================================================
# Script 2: FOSS Package Inspector
# Author: Divya Krishna | Reg No: 24BAI10705 | Slot: A11 | Date: 26 March 2026
# Course: Open Source Software (CSE0002) | VIT Bhopal
# Chosen Software: Linux Kernel
# Description: Checks if a FOSS package is installed, shows
#              its version/license, and prints a philosophy
#              note about it using a case statement.
# =============================================================

# --- The package we are inspecting for our audit ---
# For Linux kernel audit, we inspect core kernel-related tools
PACKAGE="${1:-linux-image-$(uname -r)}"   # Default: current kernel image package

echo "================================================================"
echo "         FOSS PACKAGE INSPECTOR"
echo "================================================================"
echo "  Inspecting package: $PACKAGE"
echo "----------------------------------------------------------------"

# --- Check if the package is installed using dpkg (Ubuntu/Debian) ---
if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
    # Package is installed — show details
    echo "  STATUS  : INSTALLED"
    echo ""

    # Extract version and description from dpkg
    VERSION=$(dpkg -l "$PACKAGE" 2>/dev/null | grep "^ii" | awk '{print $3}')
    DESCRIPTION=$(dpkg -l "$PACKAGE" 2>/dev/null | grep "^ii" | awk '{$1=$2=$3=$4=""; print $0}' | sed 's/^ *//')

    echo "  Version     : $VERSION"
    echo "  Description : $DESCRIPTION"
    echo ""

    # Try to get more detail from apt-cache (license info may be in copyright)
    echo "  Extended Info (from apt-cache show):"
    apt-cache show "$PACKAGE" 2>/dev/null | grep -E "^(Version|Maintainer|Section|Homepage)" | \
        while IFS=: read -r KEY VAL; do
            echo "    $KEY :$VAL"
        done

else
    # Package not found by exact name — try a broader search for kernel packages
    echo "  STATUS  : Not found as '$PACKAGE'"
    echo ""
    echo "  Searching for related kernel packages..."
    dpkg -l | grep -i "linux-image" | grep "^ii" | awk '{print "  Found: " $2 " (version " $3 ")"}' | head -5
fi

echo ""
echo "----------------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "----------------------------------------------------------------"

# --- case statement: print a philosophy note based on the package name ---
# We strip version suffixes to match the base package name
BASE_PKG=$(echo "$PACKAGE" | sed 's/-[0-9].*//' | tr '[:upper:]' '[:lower:]')

case "$BASE_PKG" in
    linux-image*|linux*)
        echo "  Linux Kernel: The foundation of modern computing."
        echo "  Linus Torvalds released it in 1991 so that everyone"
        echo "  could have a free, modifiable Unix-like OS. Today it"
        echo "  powers everything from Android phones to supercomputers."
        ;;
    apache2|httpd)
        echo "  Apache HTTP Server: the web server that helped build"
        echo "  the open internet — free for anyone to host a website."
        ;;
    mysql-server|mysql)
        echo "  MySQL: open source at the heart of millions of apps,"
        echo "  showing that dual-licensing can sustain a community."
        ;;
    vlc|vlc-bin)
        echo "  VLC: built by students in Paris, it plays anything"
        echo "  because knowledge of formats should be free."
        ;;
    firefox)
        echo "  Firefox: a nonprofit's browser fighting for an open,"
        echo "  user-respecting web against corporate monopoly."
        ;;
    python3|python)
        echo "  Python: shaped entirely by community consensus —"
        echo "  a language whose growth proves openness scales."
        ;;
    git)
        echo "  Git: Linus built it when proprietary tools failed him."
        echo "  Version control should never be locked behind a paywall."
        ;;
    libreoffice)
        echo "  LibreOffice: born from a community fork of OpenOffice,"
        echo "  proving that communities can rescue abandoned software."
        ;;
    *)
        echo "  '$PACKAGE' is open source — meaning its source code is"
        echo "  publicly available, auditable, and redistributable."
        echo "  That transparency is what makes open source trustworthy."
        ;;
esac

echo "================================================================"
echo "  Kernel License: GPL v2 — copyleft ensures freedom stays free."
echo "================================================================"
