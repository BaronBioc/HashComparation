#!/bin/bash

# Compute the SHA-1 hashes of all files in the subdirectories of the specified directory
find "$1" -type f -print0 | xargs -0 sha1sum > "hashes.txt"

#sort the file alphabeta
sort -k 2 -o "hashes.txt" "hashes.txt"

# Compares the lines of each file using the command created in C
gcc -o compare compare.c
./compare "hashes.txt" $2
