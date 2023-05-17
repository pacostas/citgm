#!/bin/sh

json_file="./lib/lookup.json"

# Extract attribute names using jq from the file
attribute_names=$(jq -r 'keys[]' "$json_file")

for attribute_name in $attribute_names; do
    echo "$attribute_name"
    if npx citgm "$attribute_name"; then
        echo "$attribute_name command succeeded."
        echo "$attribute_name" >>citgm_passed.txt # Append "$attribute_name" to output.txt

    else
        echo "$attribute_name command failed."
        echo "$attribute_name" >>citgm_failed.txt # Append "$attribute_name" to output.txt
    fi
done

exit 0
