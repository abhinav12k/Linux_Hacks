#!/usr/bin/env bash

# Prerequiste
# 1. ffmpeg 
# 2. lame

echo -ne """
Location of Video files?
1: Current directory
2: Provide directory
"""
echo ""
echo -n "Selection : "
read selection

case $selection in
    1)
	echo "Okay.."
	echo ""
	echo "Current dir is `pwd` "
	;;
    2)
    echo ""
    echo -n "Give diretory path: "
    read dir_name

# Check if given directory is valid
if [ -d $dir_name ]; then
    
    cd "${$dir_name}"
    echo "Current directory is `pwd` "
    echo 
else
    echo "Invalid directory, exiting.."
    echo ""
    exit 10
fi

    echo
    ;;
    
   *)
       echo
       echo "Wrong selection"
       exit 11
       ;;
esac

echo ""

# Create dir to store mp3 files if it doesn't exist
# First get the current directory name

current_dir=`pwd`
base_name=` basename "$current_dir"`

if [[ ! -d "$base_name"-mp3 ]]; then
    
echo "$base_name" | xargs  -d "\n" -I {} mkdir {}-mp3
    echo ""
fi
echo ""


# Begin to covert videos to mp3 audio files
# -d "\n" > Change delimiter from any whitespace to end of line character 

find . -name "*.mp4" -o -name "*.mkv" -o -name "*.webm" | xargs  -d "\n"  -I {} ffmpeg -i {} -b:a 320K -vn "$base_name"-mp3/{}.mp3 

# remove video extensions

cd "${base_name}"-mp3

for file_name in *; do      
    mv "$file_name" "`echo $file_name | sed  "s/.mp4//g;s/.mkv//g;s/.webm//g"`";
done

# Move audio directory to ~/Music

if [[ ! -d ~/Music ]]; then
    mkdir ~/Music
fi
cd ..

mv  "$base_name"-mp3 ~/Music/

# Check if conversion successfull

echo ""

if [[ $? -eq "0" ]];then
    echo " All files converted successfully"
else
    echo "Conversion failed"
    exit 1
fi

# Credits - NerdJK23
