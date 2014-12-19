#!/bin/bash

export CLASSPATH=/Users/jordi/Documents/workspace/lib/libs/:/Users/jordi/Documents/workspace/lib/pac3-comp/

for filename in $(ls tests)
do
	echo "Test file: $filename"
	java -classpath $CLASSPATH parser ./tests/$filename
done