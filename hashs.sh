#!/bin/bash

# Prompt the user to enter a directory name
read -p "Enter directory name: " dir_name

# Check if the specified directory exists and is a directory
if [ ! -d "$dir_name" ]; then
    echo "Error: $dir_name is not a directory"
    exit 1
fi

# Compute the SHA-1 hashes of all files in the subdirectories of the specified directory
find "$dir_name" -mindepth 2 -type f -print0 | xargs -0 sha1sum > "$dir_name/hashes.txt"

# Prompt the user to enter the name of the file containing the expected hashes
read -p "Enter the name of the file containing the expected hashes: " expected_hashes_file

# Check if the specified file exists and is a regular file
if [ ! -f "$expected_hashes_file" ]; then
    echo "Error: $expected_hashes_file is not a regular file"
    exit 1
fi

# Compare the computed hashes with the expected hashes
line_num=1
hash_mismatch=false
while read -r expected_hash filename; do
    computed_hash=$(grep -F "$filename" "$dir_name/hashes.txt" | awk '{print $1}')
    if ! cmp -s <(echo "$expected_hash") <(echo "$computed_hash"); then
        echo "#$line_num Hash mismatch: expected $expected_hash, computed $computed_hash for file $filename (expected hash value: $(grep -F "$filename" "$expected_hashes_file" | awk '{print $1}'))"
        hash_mismatch=true
    fi
    ((line_num++))
done < "$expected_hashes_file"

# Output the final result
if [ "$hash_mismatch" = false ]; then
    echo "All hashes match"
else
    echo "Hash mismatches found"
fi
