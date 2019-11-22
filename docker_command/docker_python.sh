#!/bin/bash
# Need to install Docker java container that should be named "python"

if [ $# -eq 0 ]
then
    docker attach python
    exit
fi

filename_full=$1
container_name="python"

docker cp ./$filename_full $container_name:./root/$filename_full
docker exec $container_name python ./root/$filename_full
docker exec $container_name rm ./root/$filename_full
