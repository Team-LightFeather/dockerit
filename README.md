# Overview
This script provides a quick way to into a shell of a container in interactive mode.

# Installation
Put this script somewhere in your PATH variable. Some lines in the script may need to be adjusted for your actual environment.

# Usage
This script will create a container of <toolname> running from the latest tag. It will mount your current directory into a "working" directory inside the container, create your user in the container, and set file permissions appropiately.
  
This script is modelled off of the "withDockerContainer" step in Jenkins Pipeline.
  
For example, if you want to run a "maven:3.8.2-openjdk-8"
```
docker pull maven:3.8.2-openjdk-8
docker tag maven:3.8.2-openjdk-8 maven:latest
dockerit maven
```
