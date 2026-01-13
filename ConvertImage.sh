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


echo -e "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | xargs -i convert "{}" "{}.$OUTPUT_EXT"
:w
