#!/bin/sh

sudo pacman -S jdk-openjdk gradle

echo "$JAVA_HOME"

java --version
javac --version
gradle --version
