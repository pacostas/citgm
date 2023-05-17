#!/bin/sh

json_file="./lib/lookup.json"

# Extract attribute names using grep and sed
attribute_names=$(grep -o '^\s*"[^"]*"' "$json_file" | sed 's/"//g')

node_version="$1"

if [ -z "$node_version" ]; then
    echo "No node_version argument provided."
    exit 1
fi

if [ "$node_version" = "test" ]; then

    for attribute_name in $attribute_names; do
        echo "$attribute_name"
    done
elif [ "$node_version" = "10" ]; then
    echo "Performing actions for Node.js version 10."
elif [ "$node_version" = "12" ]; then
    echo "Performing actions for Node.js version 12."
elif [ "$node_version" = "14" ]; then
    echo "Performing actions for Node.js version 14."
    nvm use 14

    for attribute_name in $attribute_names; do
        echo "$attribute_name"
        if npx citgm "$attribute_name"; then
            echo "$attribute_name command succeeded."
        else
            echo "$attribute_name command failed."
            echo "$attribute_name" >>output.txt # Append "$attribute_name" to output.txt
        fi
    done

elif [ "$node_version" = "16" ]; then
    echo "Performing actions for Node.js version 16."
elif [ "$node_version" = "18" ]; then
    echo "Performing actions for Node.js version 18."
elif [ "$node_version" = "20" ]; then
    echo "Performing actions for Node.js version 20."
else
    echo "Unsupported node_version: $node_version."
    exit 1
fi

exit 0
