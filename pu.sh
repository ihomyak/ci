#!/bin/bash

# Unit tests calculate code coverage and compare with config
# variables $1 - phpunit result filename
# variables $2 - number of possible coverage (parametr in config CI)
#

# get summary info
classes=$(grep -A 3 'Summary' $1 | tail -n 3 | head -n 1)
methods=$(grep -A 3 'Summary' $1 | tail -n 2 | head -n 1)
lines=$(grep -A 3 'Summary' $1 | tail -n 1)

#
classes=${classes%\%*}
methods=${methods%\%*}
lines=${lines%\%*}

classes=${classes##*\:}
methods=${methods##*\:}
lines=${lines##*\:}

#echo $classes
#echo $methods
#echo $lines

avg=$(awk '{print ($1+$2+$3)/3}' <<<"${classes} ${methods} ${lines}")

echo "AVG code coverage $avg %"
if [ $avg \< $2 ]
  then
    echo "Failing code coverage test"
    exit 1
  else
    echo "Done code coverage test"
    exit 0
fi
