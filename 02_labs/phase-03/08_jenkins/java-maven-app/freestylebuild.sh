#!/bin/bash

echo "Starting Jenkins freestyle build..."

cd 02_labs/phase-03/08_jenkins/java-maven-app

mvn clean package

echo "Freestyle build completed successfully!"