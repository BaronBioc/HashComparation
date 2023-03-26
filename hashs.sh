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
line_num=1
while read -r expected_hash filename; do
    computed_hash=$(grep -F "$filename" hashes.txt | awk '{print $1}')
    if cmp -s <(echo "$expected_hash") <(echo "$computed_hash"); then
        echo "OK"
    else
        echo "#$line_num Hash mismatch: expected $expected_hash, computed $computed_hash for file $filename"
    fi
    ((line_num++))
done < "$expected_hashes_file"
