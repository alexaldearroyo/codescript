#!/bin/bash

OUTPUT_TO_FILE=false
TEMP_FILE=$(mktemp "${TMPDIR:-/tmp}/tempfile.codescript.txt")

# Function to print the content of a file
print_file_content() {
    local file="$1"
    echo "$file:" >> "$TEMP_FILE"
    echo "" >> "$TEMP_FILE"
    cat "$file" >> "$TEMP_FILE"
    echo "" >> "$TEMP_FILE"
    echo "----------------------------------------" >> "$TEMP_FILE"
    echo "" >> "$TEMP_FILE"
}

# Check if the -o option was provided
if [[ "$1" == "-o" ]]; then
    OUTPUT_TO_FILE=true
    shift  # Remove the -o option from the arguments
fi

# Iterate over all provided arguments
for entry in "$@"; do
    # If the entry is a directory, search for files within
    if [[ -d $entry ]]; then
        for file in $(find "$entry" -type f); do
            print_file_content "$file"
        done
    # If the entry is a file, print its content
    elif [[ -f $entry ]]; then
        print_file_content "$entry"
    else
        echo "The entry $entry does not exist or is not recognized."
    fi
done

# If the -o option was used, open the output file
if $OUTPUT_TO_FILE; then
    open "$TEMP_FILE"
    # Wait for the user to close the text editor
    wait
    rm -f "$TEMP_FILE"
fi
