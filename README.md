# OSS Audit — Git
**Student Name:** Divya Krishna  
**Registration Number:** 24BAI10705  
**Course:** CSE0002 — Open Source Software | VIT Bhopal University  
**Software Audited:** Git (GPL v2)  
**Repository:** `oss-audit-24BAI10705`

---

## About This Project

This repository contains the five shell scripts for the Open Source Software Capstone Project — *The Open Source Audit*. The project audits **Git**, examining its origin story (the BitKeeper crisis of 2005), GPL v2 license, philosophy, Linux footprint, FOSS ecosystem, and a comparison with proprietary alternatives (Perforce Helix Core).

---

## Repository Contents

| File | Description |
|------|-------------|
| `script1_system_identity.sh` | Displays system info: Git version, distro, kernel, uptime, user, and GPL v2 license details |
| `script2_package_inspector.sh` | Checks if a FOSS package is installed, shows version/metadata, and prints a philosophy note (case statement) |
| `script3_disk_permission_auditor.sh` | Audits key system directories and Git-specific paths: permissions, ownership, and disk usage using a for loop |
| `script4_log_analyzer.sh` | Reads a log file line by line, counts keyword matches, and displays the last 5 matches |
| `script5_manifesto_generator.sh` | Interactively generates and saves a personalised open-source philosophy statement |
| `README.md` | This file |

The project report PDF is submitted separately via the VITyarthi portal.

---

## Environment Requirements

- **OS:** Ubuntu 22.04 LTS or any Debian-based Linux
- **Shell:** Bash (version 4.0+)
- **Dependencies:** `git`, `uname`, `whoami`, `uptime`, `dpkg`, `apt-cache`, `ls`, `du`, `grep`, `awk`, `cut`, `date` — install Git with `sudo apt install git`
- **Permissions:** Script 4 may require `sudo` to read `/var/log/syslog`

---

## Setup Instructions

### Step 1 — Clone the repository
```bash
git clone https://github.com/divyakrishna19/oss-audit-24BAI10705
cd oss-audit-24BAI10705
```

### Step 2 — Make all scripts executable
```bash
chmod +x *.sh
```

---

## Running Each Script

### Script 1 — System Identity Report
Displays system info and Git license details.
```bash
./script1_system_identity.sh
```
**Expected output:** Git version, distribution name, kernel, uptime, user info, date/time, and GPL v2 license statement.

---

### Script 2 — FOSS Package Inspector
Checks if a package is installed and prints a philosophy note.
```bash
# Inspect the git package (default)
./script2_package_inspector.sh

# Inspect a specific package
./script2_package_inspector.sh git
./script2_package_inspector.sh python3
./script2_package_inspector.sh vlc
```
**Expected output:** Package install status, version, and a philosophy note about the package.

---

### Script 3 — Disk and Permission Auditor
Audits system directories and Git-specific installation paths.
```bash
./script3_disk_permission_auditor.sh
```
**Expected output:** A formatted table of directories showing permissions, owner, group, and disk size. Also checks `/usr/bin/git`, `/usr/lib/git-core`, and `~/.gitconfig`.

---

### Script 4 — Log File Analyzer
Reads a log file and counts keyword matches.
```bash
# Analyse syslog for 'git' entries (default)
sudo ./script4_log_analyzer.sh /var/log/syslog git

# Analyse auth.log for SSH activity (used by git push/pull)
sudo ./script4_log_analyzer.sh /var/log/auth.log ssh

# Custom keyword
sudo ./script4_log_analyzer.sh /var/log/syslog error
```
**Expected output:** Match count and the last 5 matching lines.

> **Note:** On some Ubuntu systems, `/var/log/syslog` requires sudo or membership in the `adm` group: `sudo usermod -aG adm $USER`

---

### Script 5 — Open Source Manifesto Generator
Interactive — asks three questions and saves a personalised manifesto.
```bash
./script5_manifesto_generator.sh
```
**Follow the prompts:**
1. Enter a tool you use every day (e.g., `git`, `bash`, `vim`)
2. Enter one word for what software freedom means (e.g., `independence`, `control`)
3. Enter something you would build and share (e.g., `a study planner app`)

**Expected output:** A manifesto printed to the terminal and saved as `manifesto_[yourusername].txt`.

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| `Permission denied` on script | Run `chmod +x scriptname.sh` |
| `git: command not found` | Install with `sudo apt install git` |
| Log file not found (Script 4) | Script auto-detects fallbacks; or try `./script4_log_analyzer.sh /var/log/auth.log ssh` |
| `dpkg: not found` (Script 2) | Replace `dpkg -l` with `rpm -qa` for RPM-based systems |
| Script outputs nothing | Ensure Bash is your shell: `echo $SHELL` should show `/bin/bash` |

---

## License

These scripts are written for educational purposes as part of the VIT Bhopal OSS course. They may be freely used and modified.

---

*VIT Bhopal University | CSE0002 — Open Source Software | Capstone Project*
