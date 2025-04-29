#!/bin/bash

# Check if Zenity is installed
if ! command -v zenity &> /dev/null; then
    echo "Zenity not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y zenity
fi

# Welcome message
zenity --info --title="🎥 Batch AVI to MP4 Converter" \
--width=400 --height=100 \
--text="Welcome!\n\nThis tool will help you batch convert your AVI files into MP4 format quickly and beautifully."

# Prompt user to select Input Directory
INPUT_DIR=$(zenity --file-selection --directory --title="📂 Select the Input Directory (with AVI files)")
if [ ! -d "$INPUT_DIR" ]; then
    zenity --error --title="❌ Error" --text="Invalid input directory selected!"
    exit 1
fi

# Prompt user to select Output Directory
OUTPUT_DIR=$(zenity --file-selection --directory --title="💾 Select the Output Directory (for MP4 files)")
if [ ! -d "$OUTPUT_DIR" ]; then
    zenity --error --title="❌ Error" --text="Invalid output directory selected!"
    exit 1
fi

# Confirm
zenity --info --title="✅ Confirmed" --width=400 \
--text="Input Directory:\n$INPUT_DIR\n\nOutput Directory:\n$OUTPUT_DIR\n\nStarting conversion..."

# Count total AVI files for progress tracking
TOTAL_FILES=$(find "$INPUT_DIR" -maxdepth 1 -iname "*.avi" | wc -l)
if [ "$TOTAL_FILES" -eq 0 ]; then
    zenity --error --title="❌ No AVI files" --text="No AVI files found in the selected input directory."
    exit 1
fi

# Start Docker container with both volumes mounted
(
    docker run --rm -i \
        --runtime nvidia \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v "$INPUT_DIR":/input \
        -v "$OUTPUT_DIR":/output \
        -e INPUT_DIR=/input \
        -e OUTPUT_DIR=/output \
        avi-to-mp4-converter
) | zenity --progress \
    --title="🔄 Converting AVI to MP4..." \
    --text="Starting conversion..." \
    --percentage=0 \
    --width=500 \
    --auto-close \
    --auto-kill
# Final message
zenity --info --title="🎉 Conversion Complete!" \
--width=400 --text="All AVI files have been converted and saved to:\n\n$OUTPUT_DIR"

