#!/bin/bash

if [ -z "$INPUT_DIR" ] || [ -z "$OUTPUT_DIR" ]; then
    echo "Missing input or output path"
    exit 1
fi

cd "$INPUT_DIR" || exit 1

FILES=(*.avi)
TOTAL=${#FILES[@]}
COUNT=0

for file in "${FILES[@]}"; do
    if [[ -f "$file" ]]; then
        OUTPUT_FILE="${file%.avi}.mp4"
        
        # Run conversion (suppress all but fatal errors)
        ffmpeg -y -hide_banner -loglevel error -i "$file" -c:v libx264 -preset ultrafast -crf 23 -c:a aac "$OUTPUT_DIR/$OUTPUT_FILE"

        COUNT=$((COUNT + 1))
        PERCENT=$((COUNT * 100 / TOTAL))
        echo "$PERCENT"
    fi
done

# Ensure it ends at 100%
echo 100
