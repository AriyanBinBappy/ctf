#!/bin/bash

# === Banner ===
echo "📦 Extracting ctf.zip ..."
echo "------------------------------"

# Check if file exists
if [ ! -f "ctf.zip" ]; then
    echo "❌ Error: ctf.zip not found in current directory."
    exit 1
fi

# Check for unzip
if ! command -v unzip &> /dev/null; then
    echo "🔍 'unzip' not found. Trying to install..."

    # Detect environment: Termux or Linux
    if [ -f /data/data/com.termux/files/usr/bin/pkg ]; then
        echo "📱 Detected Termux environment."
        pkg install -y unzip || { echo "❌ Failed to install unzip."; exit 1; }
    elif [ -f /etc/debian_version ]; then
        echo "💻 Detected Debian-based Linux (e.g., Kali)."
        sudo apt update && sudo apt install -y unzip || { echo "❌ Failed to install unzip."; exit 1; }
    else
        echo "❌ Unknown environment. Please install 'unzip' manually."
        exit 1
    fi
fi

# Create output folder
mkdir -p ctf

# Extract zip
unzip -o ctf.zip -d ctf

if [ $? -eq 0 ]; then
    echo "✅ Extraction complete. Files are in the 'ctf/' directory."
else
    echo "❌ Extraction failed."
    exit 1
fi
