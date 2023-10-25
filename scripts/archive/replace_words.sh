#!/bin/bash

# Check if at least 3 arguments are provided
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <filename> <word_to_replace> <replacement_word> [...]"
    exit 1
fi

# The file to modify
FILE="$1"

# Check if the file exists
if [ ! -f "$FILE" ]; then
    echo "File $FILE does not exist."
    exit 1
fi

# Shift the arguments to remove the filename from the list
shift

# Loop through the arguments two at a time
while [ "$#" -ge 2 ]; do
    WORD_TO_REPLACE="$1"
    REPLACEMENT_WORD="$2"

    # Use sed to replace the words
    sed -i "s/\b$WORD_TO_REPLACE\b/$REPLACEMENT_WORD/g" "$FILE"

    # Shift the arguments to get the next pair
    shift 2
done

echo "Words replaced successfully."
