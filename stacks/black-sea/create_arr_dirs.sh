#!/bin/bash

if [ -z "$POOL" ]; then
  echo "Error: POOL variable is not set."
  echo "Please set the POOL variable before running the script, e.g.:"
  echo ""
  echo "  POOL=tank ./create_arr_dirs.sh"
  echo ""
  exit 1
fi

BASE_DIR="/mnt/${POOL}/arr"

DIRS=(
  "media/movies"
  "media/movies-animes"
  "media/tv"
  "media/tv-animes"
  "torrents/movies"
  "torrents/movies-animes"
  "torrents/tv"
  "torrents/tv-animes"
)

for DIR in "${DIRS[@]}"; do
  FULL_PATH="${BASE_DIR}/${DIR}"
  mkdir -p "$FULL_PATH"
  echo "Created: $FULL_PATH"
done
