#!/usr/bin/env bash

set -e -u -x

while getopts "s:" arg; do
  case "$arg" in
    s) site=$OPTARG;;
  esac
done
shift $((OPTIND-1))

for dest in "$@"; do
rsync -rLpt --exclude=.DS_Store "$site" "$dest"
done