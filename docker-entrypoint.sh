#!/bin/bash
set -e

if [ "$1" = 'duplicity' ]; then
    shift
    exec /usr/local/bin/duplicity "$@"
fi

exec "$@"

