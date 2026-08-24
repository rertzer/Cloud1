#!/bin/bash

if [ $# -ne 1 ]
then
	echo "require one argument"
	return 1
fi

mkdir -p roles/$1/files
mkdir  roles/$1/templates
mkdir  roles/$1/tasks
mkdir  roles/$1/handlers
mkdir  roles/$1/defaults
mkdir  roles/$1/meta
mkdir  roles/$1/vars
