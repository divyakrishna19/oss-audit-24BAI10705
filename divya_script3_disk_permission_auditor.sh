#!/bin/bash
# =============================================================
# Script 3: Disk and Permission Auditor
# Author: Divya Krishna | Reg No: 24BAI10705 | Slot: A11 | Date: 26 March 2026
# Course: Open Source Software (CSE0002) | VIT Bhopal
# Chosen Software: Linux Kernel
# Description: Loops through key system directories, reports
#              their disk usage and ownership/permissions.
#              Also checks Linux kernel-specific directories.
# =============================================================

# --- List of standard system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/boot" "/lib/modules")

echo "================================================================"
echo "         DISK AND PERMISSION AUDITOR"
echo "         Linux Kernel Audit — Directory Report"
echo "================================================================"
printf "  %-20s %-30s %-8s\n" "DIRECTORY" "PERMISSIONS (perm/owner/group)" "SIZE"
echo "  --------------------------------------------------------------------"

# --- for loop: iterate over each directory in the array ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions, owner, and group using ls -ld and awk
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # Get disk usage; suppress permission errors with 2>/dev/null
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        printf "  %-20s %-10s %-10s %-10s %-8s\n" "$DIR" "$PERMS" "$OWNER" "$GROUP" "${SIZE:-N/A}"
    else
        # Directory does not exist on this system
        printf "  %-20s %s\n" "$DIR" "[NOT FOUND on this system]"
    fi
done

echo ""
echo "================================================================"
echo "  LINUX KERNEL SPECIFIC DIRECTORY CHECK"
echo "================================================================"
echo ""
echo "  The Linux kernel installs into specific directories."
echo "  Checking for kernel-related paths..."
echo ""

# --- Array of kernel-specific directories and files ---
KERNEL_PATHS=(
    "/boot"
    "/boot/grub"
    "/lib/modules/$(uname -r)"
    "/proc/version"
    "/proc/cmdline"
    "/sys/kernel"
)

for KPATH in "${KERNEL_PATHS[@]}"; do
    if [ -e "$KPATH" ]; then
        # Check if it is a file or directory and display accordingly
        if [ -d "$KPATH" ]; then
            PERMS=$(ls -ld "$KPATH" | awk '{print $1, $3, $4}')
            SIZE=$(du -sh "$KPATH" 2>/dev/null | cut -f1)
            echo "  [DIR]  $KPATH"
            echo "         Permissions/Owner/Group: $PERMS | Size: ${SIZE:-N/A}"
        else
            # For files (like /proc/version), show first 80 chars of content
            PERMS=$(ls -l "$KPATH" | awk '{print $1, $3, $4}')
            echo "  [FILE] $KPATH"
            echo "         Permissions: $PERMS"
            echo "         Content: $(head -c 80 "$KPATH" 2>/dev/null)"
        fi
        echo ""
    else
        echo "  [MISS] $KPATH — not found"
        echo ""
    fi
done

echo "================================================================"
echo "  WHY PERMISSIONS MATTER IN OPEN SOURCE"
echo "================================================================"
echo ""
echo "  In Linux, file permissions are part of the security model."
echo "  /boot is owned by root — only root should modify the kernel."
echo "  /etc is owned by root but readable by all — transparency"
echo "  with controlled modification is a Unix philosophy principle."
echo "  /tmp is world-writable (1777 sticky bit) — open but safe."
echo ""
echo "  This mirrors open source: publicly readable (anyone can audit)"
echo "  but write access is controlled (maintainer approval required)."
echo "================================================================"
