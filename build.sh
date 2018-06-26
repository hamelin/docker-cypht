#!/bin/bash
path_repo=$(dirname $0)
path_cypht="$path_repo/cypht"
pushd "$path_cypht"
version_cypht=$(git describe --always --tags)
popd
cd "$path_repo"
version_image=$(git describe --always)
user_docker=$(jq --raw-output '.auths."https://index.docker.io/v1/".auth' $HOME/.docker/config.json \
    | base64 -d \
    | awk -F: '1{print $1}')
test "$?" -eq 0 || exit $?
tag_docker="$user_docker/cypht:$version_cypht--$version_image"
cmd="docker build --tag $tag_docker ."
echo "Building: $cmd"
$cmd || exit $?
