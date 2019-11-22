#!/bin/bash
# Need to install Docker gcc container that should be named "gcc"

if [ $# -eq 0 ]
then
    echo "docker_c.sh <Filename to compile>"
    exit
fi

filename_full=$1
filename=$(echo $1 | cut -f 1 -d'.')
filename_out="$filename.out"
fileext=$(echo $1 | cut -f 2 -d'.')
container_name="gcc"

docker cp ./$filename_full $container_name:./root/$filename_full

if [ "$fileext" = "c" ]
then
    docker exec $container_name  gcc -o ./root/$filename_out ./root/$filename_full
else
    docker exec $container_name  g++ -o ./root/$filename_out ./root/$filename_full
fi

docker exec $container_name ./root/$filename_out

docker cp $container_name:./root/$filename_out ./$filename_out
docker exec $container_name rm ./root/$filename_full
docker exec $container_name rm ./root/$filename_out