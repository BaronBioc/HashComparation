#!/bin/bash

#read directory;
read -r dir
read -r checkHash

		

#get the hashs of all files in the subdirectories of the teste folder and store them in a text file;
find "$dir" -type f -exec sha1sum {} \; > hashReg.txt

#sort(): sort the hashs in the text file alphabetacally and numerically by their source file;
sort hashReg.txt

# compare the stored hashes with expected results and point out differences
diff -q -u hashReg.txt "$checkHash" > diff.txt

# check if there are any differences in the hashes
if [ -s diff.txt ]; then
  # print the lines of the different hashes
  cat diff.txt
else
  # print ok
  echo "ok"
fi


