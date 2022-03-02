#!/usr/bin/env bash

cpuname=$(uname -p)
docker build -t crank-controller --build-arg CPUNAME=$cpuname -f Dockerfile ../../