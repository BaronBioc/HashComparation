#!/bin/bash

# Prompt the user to enter a directory name
echo "Enter directory name:"
read dir_name

# Compute the SHA-1 hashes of all files in the subdirectories of the specified directory
cd "$dir_name"
find . -mindepth 2 -type f -print0 | xargs -0 sha1sum > hashes.txt

# Prompt the user to enter the name of the file containing the expected hashes
echo "Enter the name of the file containing the expected hashes:"
read expected_hashes_file

# Compare the computed hashes with the expected hashes
diff_output=$(awk '{print $1}' hashes.txt | diff -u - <(awk '{print $1}' "$expected_hashes_file"))
if [ $? -eq 0 ]; then
    echo "All hashes match the expected values."
else
    echo "Some hashes do not match the expected values:"
    echo "$diff_output"
fi
