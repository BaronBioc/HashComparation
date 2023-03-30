#!/bin/bash

# Prompt the user to enter a directory name
read -p "Enter directory name: " dir_name

# Compute the SHA-1 hashes of all files in the subdirectories of the specified directory
find "$dir_name" -mindepth 2 -type f -print0 | xargs -0 sha1sum > "hashes.txt"

# Prompt the user to enter the name of the file containing the expected hashes
read -p "Enter the name of the file containing the expected hashes: " expected_hashes_file

# Compares the lines of each file using the command created in C

gcc -o compare compare.c

./compare "hashes.txt" $expected_hashes_file

