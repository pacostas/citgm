#!/bin/sh

json_file="./lib/lookup.json"

# Extract attribute names using grep and sed
attribute_names=$(grep -o '^\s*"[^"]*"' "$json_file" | sed 's/"//g')

for attribute_name in $attribute_names; do
    echo "$attribute_name"
    if npx citgm "$attribute_name"; then
        echo "$attribute_name command succeeded."
    else
        echo "$attribute_name command failed."
        echo "$attribute_name" >>output.txt # Append "$attribute_name" to output.txt
    fi
done

exit 0
