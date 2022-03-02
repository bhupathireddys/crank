#!/usr/bin/env bash

url="http://*:5010"
name="crank-controller"
others=""

while [ $# -ne 0 ]
do
    case "$1" in
        --url)
            shift
            url="$1"
            shift
            ;;
        --name)
            shift
            name="$1"
            shift
            ;;
        *)
            others+=" $1"
            shift
            ;;
    esac
done

docker run -it --name $name -d --network host --privileged -v ~/docker.controller:/app/data crank-controller