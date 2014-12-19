#!/bin/bash

export CLASSPATH=/Users/jordi/Documents/workspace/lib/libs/:/Users/jordi/Documents/workspace/lib/Compilers/3_Semantic
java -classpath $CLASSPATH JLex.Main pac3.jlex
java -classpath $CLASSPATH java_cup.Main pac3.cup
javac -classpath $CLASSPATH parser.java sym.java pac3.jlex.java



for filename in $(ls tests)
do
	echo "Test file: $filename"
	java -classpath $CLASSPATH parser ./tests/$filename
done