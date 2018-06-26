#!/bin/bash
path_repo=$(dirname $0)
path_cypht="$path_repo/cypht"
pushd "$path_cypht"
cypht_version=$(git describe --always --tags)
popd
cd "$path_repo"
user_docker=$(jq --raw-output '.auths."https://index.docker.io/v1/".auth' $HOME/.docker/config.json \
    | base64 -d \
    | awk -F: '1{print $1}')
test "$?" -eq 0 || exit $?
tag_docker="$user_docker/cypht:$cypht_version"
cmd="docker build --tag $tag_docker ."
echo "Building: $cmd"
$cmd || exit $?
echo "$tag_docker" >&3
