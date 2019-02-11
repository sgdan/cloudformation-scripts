#!/bin/bash

if [ -z "$1" ]; then
    echo "usage: update.sh <stack>"
    exit 1
fi

name=$1

if [ -f $name.json ]; then
  params="--parameters file://$name.json"
fi

desc=$(aws cloudformation describe-stacks --stack-name $name 2>&1)
if [ $? -ne 0 ]; then action=create; else action=update; fi
echo $name: $action
aws cloudformation $action-stack \
  --stack-name $name \
  --template-body file://$name.yml \
  --capabilities CAPABILITY_IAM $params
