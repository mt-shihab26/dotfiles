#!/bin/sh

sudo pacman -S jdk-openjdk gradle maven

echo "$JAVA_HOME"

java --version
javac --version
gradle --version
mvn --version
