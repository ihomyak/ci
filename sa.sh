#!/usr/bin/env bash

# Universal script for any static analyzer
# variables $1 - static analyzer result filename
# variables $2 - number of possible errors (parametr in config CI)
#

result=$(grep -c '.' $1)
echo "found $result errors"
if [ $result -gt $2 ]
  then
    echo "Failing static analyzer test"
    exit $result
  else
    echo "Done static analyzer test"
    exit 0
fi
