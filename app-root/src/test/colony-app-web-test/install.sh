#!/bin/bash -l

id=$1
go build -o $id
mv -f $id $EC_APP_PATH/web
