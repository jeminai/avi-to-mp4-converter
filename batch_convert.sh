#!/bin/bash

# Check input and output
if [ -z "$INPUT_DIR" ] || [ -z "$OUTPUT_DIR" ]; then
    echo "ERROR: No input/output directory provided."
    exit 1
fi

cd "$INPUT_DIR"

FILES=(*.avi)
TOTAL_FILES=${#FILES[@]}
COUNTER=0

for file in "${FILES[@]}"; do
    if [[ -f "$file" ]]; then
        output="${file%.avi}.mp4"
        ffmpeg -hide_banner -loglevel error -y -hwaccel auto -i "$file" -c:v libx264 -preset ultrafast -crf 23 -c:a aac "$OUTPUT_DIR/$output"

        COUNTER=$((COUNTER + 1))
        PERCENT=$((COUNTER * 100 / TOTAL_FILES))

        echo "$PERCENT"
    fi
done

# 100% just in case
echo "100"

