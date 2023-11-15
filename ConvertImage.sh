#!/usr/bin/env bash

OUTPUT_EXT=$(zenity --list \
    --title="Convert image type" \
    --print-column=2 \
    --column="File type" --column="Extension" \
    JPEG jpeg\
    PNG png\
    WEBP webp
    )

if [ -z $OUTPUT_EXT ]; then
    exit 0
fi


echo -e "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | xargs -i convert "{}" "{}.$OUTPUT_EXT"