#!/bin/bash


############################################
## Changing font color
############################################

function font()
{
	case $1 in
		"white" )
			color=39
			;;
		"green" )
			color=32
		;;
		"yellow" )
			color=33
		;;
		"blue" )
			color=34
		;;
	esac
	echo -e "\e[${color}m"
}

############################################
## Prints string with color and optional
## parameter
## string $1 color
## string $2 string to be print
## string $3 optional parametr eg. version
############################################
function print()
{
	font $1
	echo $2 $3
	font 'white'
}

############################################
## Stopping script and waiting for 
## user reaction
############################################

function enter()
{
	print 'blue'
	echo 'Press ENTER to continue';
	read enter;
	print 'white'
}