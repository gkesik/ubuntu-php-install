#!/bin/bash


############################################
## Download and install program in /opt/
## string $1 url to download
## string $2 filename 
## string $3 directory name
############################################
function download()
{
	url=$1
	filename=$2
	directory=$3

	wget $url -O $filename --no-check-certificate
	sudo mv $PWD/$filename /opt/
	sudo tar -xvf /opt/$filename -C /opt/
	sudo rm /opt/$filename
}