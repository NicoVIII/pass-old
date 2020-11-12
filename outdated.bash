#!/bin/bash

# Activate globbing
shopt -s globstar

# Required age
OLD=$((60 * 60 * 24 * 365))
NEARLY_OLD=$((60 * 60 * 24 * 300))

# Get current timestamp
CURR=$(date +"%s")

(
    cd "$PREFIX"

    # Loop over all password files
    for f in **/*.gpg
    do
        # Get timestamp of last change of file
        PASS=$(git log -1 --format="%at" -- "$f")
        AGE=$(($CURR - $PASS))

        # Echo message, if password is old
        if (( $AGE > $OLD ))
        then
            echo "$f is too old."
        elif (( $AGE > $NEARLY_OLD ))
        then
            echo "$f is nearly too old."
        fi
    done
)
exit 0
