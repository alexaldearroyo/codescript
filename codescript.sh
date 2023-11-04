#!/bin/bash

OUTPUT_FILENAME="$(pwd)/temp_codescript.txt"

lsof +D "$(dirname "$OUTPUT_FILENAME")" | grep $(basename "$OUTPUT_FILENAME") | awk '{print $2}' | uniq | xargs -r kill

rm -f "$OUTPUT_FILENAME"

OUTPUT_TO_FILE=false

print_file_content() {
    local file="$1"
    if $OUTPUT_TO_FILE; then
        echo "// $file:" >> "$OUTPUT_FILENAME"
        echo "" >> "$OUTPUT_FILENAME"
        cat "$file" >> "$OUTPUT_FILENAME"
        echo "" >> "$OUTPUT_FILENAME"
        echo "----------------------------------------" >> "$OUTPUT_FILENAME"
        echo "" >> "$OUTPUT_FILENAME"
    else
        echo "// $file:"
        echo ""
        cat "$file"
        echo ""
        echo "----------------------------------------"
        echo ""
    fi
}

if [[ "$1" == "-o" ]]; then
    OUTPUT_TO_FILE=true
    shift
fi

for entry in "$@"; do
    if [[ -d $entry ]]; then
        for file in $(find "$entry" -type f); do
            print_file_content "$file"
        done
    elif [[ -f $entry ]]; then
        print_file_content "$entry"
    else
        echo "Entry $entry does not exit or it is not recognized."
    fi
done

if $OUTPUT_TO_FILE; then
    sync
    sleep 1
    open "$OUTPUT_FILENAME"
fi
