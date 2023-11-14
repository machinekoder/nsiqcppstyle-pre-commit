#!/bin/bash

# Ensuring the script is run with bash
if [ ! "$BASH_VERSION" ]; then
    echo "Warning: this script should be executed with bash"
    exec /bin/bash "$0" "$@"
fi

# Save the current directory (repository root)
REPO_ROOT_DIR="$(pwd)"

# Change to the directory where the script is located
cd "$(dirname "${BASH_SOURCE[0]}")" || exit

# Iterate over each file passed as an argument
for file in "$@"; do
    # Check if the file exists in the repository
    if [[ -f "$REPO_ROOT_DIR/$file" ]]; then
        # Resolve the path
        FILE_PATH="$(realpath --relative-to="$(pwd)" "$REPO_ROOT_DIR/$file")"

        # Run nsiqcppstyle for each file
        python3 ./nsiqcppstyle/nsiqcppstyle.py -f ${REPO_ROOT_DIR}/filefilter.txt -q "$FILE_PATH"
    else
        echo "Warning: '$file' is not a valid file."
    fi
done
