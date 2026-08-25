#!/bin/bash

if [ $# -ne 1 ]
then
	echo "require one argument"
	return 1
fi

roles_path="playdoh"

mkdir  -p ${roles_path}/roles/$1/files
mkdir  ${roles_path}/roles/$1/templates
mkdir  ${roles_path}/roles/$1/tasks
mkdir  ${roles_path}/roles/$1/handlers
mkdir  ${roles_path}/roles/$1/defaults
mkdir  ${roles_path}/roles/$1/meta
mkdir  ${roles_path}/roles/$1/vars
