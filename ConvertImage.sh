#!/usr/bin/env bash
#
# place script in: /.local/share/nautilus/scripts/
# to run: in nautilus, select on the file(s), right-click and select scripts, select ConvertImage.sh

OUTPUT_EXT=$(zenity --list \
    --title="Convert selected image files to" \
    --print-column=2 \
    --column="File type" --column="Extension" \
    JPEG jpeg\
    PNG png\
    WEBP webp
    )

if [ -z $OUTPUT_EXT ]; then
    exit 0
fi

# STEP 2: Ask for the resize percentage using a slider
# Default value is 100% (no resizing)
SCALE=$(zenity --scale \
    --title="Resize Image" \
    --text="Set the scale percentage (100% = original size):" \
    --value=100 \
    --min-value=1 \
    --max-value=200 \
    --step=5)

# If the user pressed Cancel or closed the window
if [ -z "$SCALE" ]; then
    exit 0
fi

# STEP 3: Process and convert the files
echo -e "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | while read -r FILE; do
    # Skip empty lines
    [ -z "$FILE" ] && continue
    
    # Extract directory and file name to avoid ugly extensions like ".jpg.webp"
    DIR=$(dirname "$FILE")
    FILENAME=$(basename "$FILE")
    BASENAME="${FILENAME%.*}"
    
    OUTPUT_FILE="$DIR/${BASENAME}_resized.$OUTPUT_EXT"
    
    # If scale is 100%, just convert without resizing
    if [ "$SCALE" -eq 100 ]; then
        convert "$FILE" "$OUTPUT_FILE"
    else
        convert "$FILE" -resize "${SCALE}%" "$OUTPUT_FILE"
    fi
done
