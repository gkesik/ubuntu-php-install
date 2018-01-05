#!/bin/bash

############################################
## Checking correct answer
############################################

function question()
{
	read answer
	while [[ $answer != @($1|$2)* ]];
	 do
	 echo '('$1'/'$2')'
	 read answer;
	done;

if [ $answer == $1 ]
then
	echo true
else
	echo false;
fi;
}