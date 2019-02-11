#!/bin/sh

if [ -z "$1" ]; then
    echo "usage: delete.sh <stack>"
    exit 1
fi

name=$1

desc=$(aws cloudformation describe-stacks --stack-name $name 2>&1)
if [ $? -ne 0 ]; then
  echo Unable to delete, stack not found: $name
else
  echo Deleting stack: $name
  aws cloudformation delete-stack --stack-name $name
fi
