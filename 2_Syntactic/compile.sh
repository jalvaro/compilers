#!/bin/bash

export CLASSPATH=/Users/jordi/Documents/workspace/lib/libs/:/Users/jordi/Documents/workspace/lib/pac2-comp/
java -classpath $CLASSPATH JLex.Main pac2.lex
java -classpath $CLASSPATH java_cup.Main pac2.cup
javac -classpath $CLASSPATH parser.java sym.java pac2.lex.java

java -classpath $CLASSPATH parser test.java