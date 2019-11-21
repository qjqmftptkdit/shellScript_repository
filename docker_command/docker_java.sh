#!/bin/bash
# Need to install Docker java container that should be named "java"

if [ $# -eq 0 ]
then
    echo "docker_java.sh <Filename to compile>"
    exit
fi

filename=$(echo $1 | cut -f 1 -d'.')
filename_java="$filename.java"
filename_class="$filename.class"
container_name="java"

docker cp ./$filename_java java:./root/$filename_java
docker exec $container_name javac ./root/$filename_java

docker exec $container_name java -cp ./root $filename

docker cp java:/root/$filename_class ./$filename_class
docker exec $container_name rm ./root/$filename_java
docker exec $container_name rm ./root/$filename_class