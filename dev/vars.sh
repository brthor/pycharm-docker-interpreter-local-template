#!/usr/bin/env bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ "$SOURCE" != /* ]] && SOURCE="$DIR_DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

export REPO_ROOT_DIR="$DIR_DIR/.."
export PROJECT_NAME="$(basename $(readlink -f $REPO_ROOT_DIR))"

export DEV_CONTAINER_BASE_NAME="$PROJECT_NAME-dev"
export LOCAL_DOCKER_SSH_PORT="2222"
