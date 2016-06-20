#!/bin/bash

# TODO: Variables aren't working with tput, don't know why
x_base = 15
y_base = 3
 
tput clear

tput cup 3 15
 
tput setaf 7
tput setab 0

greeting="To Chris:"
for (( i=0; i<=${#greeting}; i++ )); do
  echo -ne  "${greeting:0:$i}"
  sleep 0.1
  tput cup 3 15
done

tput cup 5 15

message="Congrats on turning 24!! You're not old yet, but you are certainly getting wiser."

for (( i=0; i<=${#message}; i++ )); do
  echo -ne "${message:0:$i}"
  sleep 0.1
  tput cup 5 15
done

tput cup 7 15

message="I am infinitely grateful for the time you've shared with me and admire how much"

for (( i=0; i<=${#message}; i++ )); do
  echo -ne "${message:0:$i}"
  sleep 0.1
  tput cup 7 15
done

tput cup 9 15

message="you love to learn, build, and solve problems."

for (( i=0; i<=${#message}; i++ )); do
  echo -ne "${message:0:$i}"
  sleep 0.1
  tput cup 9 15
done

tput cup 11 15

message="Here's some love from a few of your friends..."

for (( i=0; i<=${#message}; i++ )); do
  echo -ne "${message:0:$i}"
  sleep 0.1
  tput cup 11 15
done

tput cup 13 15
tput bold
tput blink
tput setaf 5 
read -sn 1 -p "Press any key to continue..." 

tput clear

tput cup 3 15
tput blink
tput setab 0
tput setaf 5
echo "H A P P Y   B I R T H D A Y ! ! !"
tput sgr0
 
tput setaf 6
tput bold 
tput cup 5 15
read -p "Enter a number between 0 and 21, inclusive, or just press enter to exit: " choice

while [ "$choice" != "" ]; do

    if [ $choice -gt 21 -o $choice -lt 0 ]; then
	echo "Bad choice. I said [0, 21]!"
    else
	tput clear

	tput cup 3 15
	tput blink
	tput setab 0
	tput setaf 5
	echo "H A P P Y   B I R T H D A Y ! ! !"
	tput sgr0

	tput setaf 6
	tput bold

	echo ""
	echo "From: "
	sqlite3 .chris.sqlite3 "select name || ' 

' ||  message from messages limit $choice, 1";
	echo ""

    fi
    read -p "Enter a number between 0 and 21 or just press enter to exit: " choice
done
 
tput clear
tput sgr0
tput rc

# <3 