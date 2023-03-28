#!/bin/bash



# Prompt the user to enter a directory name

read -p "Enter directory name: " dir_name



# Compute the SHA-1 hashes of all files in the subdirectories of the specified directory

find "$dir_name" -mindepth 2 -type f -print0 | xargs -0 sha1sum > "$dir_name/hashes.txt"



# Prompt the user to enter the name of the file containing the expected hashes

read -p "Enter the name of the file containing the expected hashes: " expected_hashes_file





# Compare the computed hashes with the expected hashes

line_num=1

hash_mismatch=false

while read -r expected_hash filename; do

    computed_hash=$(grep -F "$filename" "$dir_name/hashes.txt" | awk '{print $1}')

    if ! cmp -s <(echo "$expected_hash") <(echo "$computed_hash"); then

        echo -e "#$line_num: $expected_hash $filename \n $computed_hash $filename"

        hash_mismatch=true

    fi

    ((line_num++))

done < "$expected_hashes_file"



# Output the final result

if [ "$hash_mismatch" = false ]; then

    echo "OK"

fi
