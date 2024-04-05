#!/usr/bin/env bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ "$SOURCE" != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

set -ex

. "$DIR/vars.sh"

image_name="$DEV_CONTAINER_BASE_NAME"
container_name="$DEV_CONTAINER_BASE_NAME-exec"

(cd $DIR && docker build -q -t $image_name -f ./Dockerfile.dev ../)

docker run \
    -v $REPO_ROOT_DIR/:/app/ \
    --workdir /app/ \
    -it $container_name "$@"