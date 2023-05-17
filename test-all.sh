#!/bin/sh

json_file="./lib/lookup.json"
node_version=$(node -v | cut -d. -f1)
citgm_failed_file="node_${node_version}_citgm_failed.txt"
citgm_passed_file="node_${node_version}_citgm_failed.txt"

total_attributes=$(jq -r 'keys[]' "$json_file" | wc -l)
completed_attributes=0

# Extract attribute names using jq from the file
attribute_names=$(jq -r 'keys[]' "$json_file")

echo "Node version: $node_version"

for attribute_name in $attribute_names; do
    completed_attributes=$((completed_attributes + 1))

    echo "Processing $attribute_name [$completed_attributes/$total_attributes]"
    if output=$(./bin/citgm.js citgm "$attribute_name" 2>&1); then
        echo "$attribute_name command succeeded."
        echo "$attribute_name: $output" >> "$citgm_passed_file"
    else
        echo "$attribute_name command failed."
        echo "$attribute_name: $output" >> "$citgm_failed_file"
    fi
done

exit 0
