#!/bin/sh
set -e

dind dockerd $DOCKERD_OPTIONS &

exec "$@"
