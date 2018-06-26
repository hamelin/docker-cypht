#!/bin/bash
path_repo=$(dirname $0)
cd "$path_repo"
. ./build.sh 
cmd="docker push $tag_docker"
echo "Pushing: $cmd"
$cmd || exit $?
