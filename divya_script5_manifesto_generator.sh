#!/bin/bash
# =============================================================
# Script 5: Open Source Manifesto Generator
# Author: Divya Krishna | Reg No: 24BAI10705 | Slot: A11 | Date: 26 March 2026
# Course: Open Source Software (CSE0002) | VIT Bhopal
# Chosen Software: Linux Kernel
# Description: Interactively asks 3 questions and generates
#              a personalised open source philosophy statement,
#              saved to a .txt file.
# Concepts: read (user input), string concatenation, file
#           output with >, date command, alias demonstration.
# =============================================================

# --- Alias demonstration (aliases are normally set in ~/.bashrc) ---
# An alias creates a shortcut for a longer command.
# alias ll='ls -la'       # 'll' becomes shorthand for 'ls -la'
# alias mykernel='uname -r'  # 'mykernel' prints current kernel version
# We cannot use aliases inside scripts by default, but we demonstrate
# the concept here with a comment and a function equivalent:

# Function equivalent of an alias — prints the kernel version
mykernel() {
    uname -r
}

# --- Display introduction ---
echo "================================================================"
echo "       OPEN SOURCE MANIFESTO GENERATOR"
echo "       Linux Kernel Audit — Personal Philosophy Statement"
echo "================================================================"
echo ""
echo "  Answer three questions to generate your personal open source"
echo "  manifesto. Your answers will shape a unique statement about"
echo "  why you believe in open software."
echo ""
echo "================================================================"
echo ""

# --- Question 1: read for user input ---
read -p "  1. Name one open-source tool you use every day: " TOOL

# --- Validate input is not empty ---
while [ -z "$TOOL" ]; do
    echo "  Please enter a tool name (e.g., git, bash, Linux, Firefox)"
    read -p "  1. Name one open-source tool you use every day: " TOOL
done

# --- Question 2 ---
read -p "  2. In one word, what does 'freedom' mean to you in software? " FREEDOM

while [ -z "$FREEDOM" ]; do
    echo "  Please enter one word (e.g., choice, transparency, power)"
    read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
done

# --- Question 3 ---
read -p "  3. Name one thing you would build and share freely: " BUILD

while [ -z "$BUILD" ]; do
    echo "  Please enter something you would build (e.g., a music player, an OS)"
    read -p "  3. Name one thing you would build and share freely: " BUILD
done

echo ""
echo "  Generating your manifesto..."
echo ""

# --- Gather additional context for the manifesto ---
DATE=$(date '+%d %B %Y')              # Human-readable date
KERNEL_VER=$(mykernel)                # Use our alias-equivalent function
AUTHOR=$(whoami)                      # Current user as the author

# --- Output filename using string concatenation ---
OUTPUT="manifesto_${AUTHOR}.txt"

# --- Compose the manifesto using echo and >> (append to file) ---
# First, create/overwrite the file with >
echo "================================================================" > "$OUTPUT"
echo "         MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "         Written on $DATE | Running kernel: $KERNEL_VER" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- Main manifesto paragraph using the user's answers ---
echo "I believe that software should serve people, not corporations." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Every day, I rely on $TOOL — a tool built not by a single" >> "$OUTPUT"
echo "company seeking profit, but by developers across the world who" >> "$OUTPUT"
echo "believed that the knowledge they had should be shared freely." >> "$OUTPUT"
echo "That choice changed computing. It changed my world." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "To me, freedom in software means $FREEDOM. Not just the freedom" >> "$OUTPUT"
echo "to use a program, but the freedom to understand it, question it," >> "$OUTPUT"
echo "fix it, and pass it on better than you found it. This is what" >> "$OUTPUT"
echo "the GPL v2 — the license that governs the Linux kernel itself —" >> "$OUTPUT"
echo "was designed to protect. It is not merely a legal document; it" >> "$OUTPUT"
echo "is a statement that human knowledge belongs to humanity." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "If I could build anything and release it to the world, I would" >> "$OUTPUT"
echo "build $BUILD — and I would release it under an open license." >> "$OUTPUT"
echo "Because the greatest software in history was not made to be" >> "$OUTPUT"
echo "locked away. The Linux kernel, Python, Git, Firefox — all of" >> "$OUTPUT"
echo "them grew because someone chose openness over ownership." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "I stand on the shoulders of giants. I intend to add to that" >> "$OUTPUT"
echo "height, not wall it off." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Signed: $AUTHOR" >> "$OUTPUT"
echo "Date  : $DATE" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"

# --- Confirm and display the saved manifesto ---
echo "  ✓ Manifesto saved to: $OUTPUT"
echo ""
echo "================================================================"
cat "$OUTPUT"
echo ""
echo "================================================================"
echo "  To view it again later: cat $OUTPUT"
echo "  To share it: cp $OUTPUT ~/Desktop/ (if GUI is available)"
echo "================================================================"
