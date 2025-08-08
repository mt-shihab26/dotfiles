#!/bin/sh

sudo pacman -S jdk-openjdk

java -version
javac -version

echo "$JAVA_HOME"
