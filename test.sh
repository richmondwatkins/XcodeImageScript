#!/bin/bash

clear

echo "Hello "$USER". This script will help setup your aloompa project!"
echo "Please enter the git url or hit ENTER to user the default."
read input_git


function cloneRepo () {

  echo "What would you like to name this project?"

  read project_name

  # git clone "https://github.com/richmondwatkins/InstagramClone" "$project_name"

  # rm -rf "$project_name"
  setUpProjectData $project_name
}

function setUpProjectData () {
  # echo "Enter festival name:"
  # read festival_name
  # echo "Enter festival city,state:"
  # read festival_location
  # echo "Enter festival timezone"
  # read festival_timezone
  # echo "Enter app ID:"
  # read festival_id

  plutil -convert json $1/Info.plist -o Data.json

  jq 'CFBundleName="canada"' Data.json
  exit
}


if [-n "$input_git"]; then

  echo "Valid git"

else
  echo "Using Default"

  cloneRepo
  setUpProjectData
fi

# read menu_items

# for (( i=1; i <= menu_items; i++ ))
# do
 
# done

