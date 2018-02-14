#!/bin/bash

set -eu

tile_dir="$( cd "$( dirname "$0" )" && pwd )"

usage() {
  cat <<EOF
Usage: $0 -v 1.2.3"
Options:
  -v (required) version of the tile to build
  -h show this help text
EOF
}

version=""

while getopts "v:h" opt; do
  case "${opt}" in
    v)
      version="$OPTARG"
      ;;
    h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: ${opt}"
      usage
      exit 1
      ;;
  esac
done

if [ -z "${version}" ]; then
  usage
  exit 1
fi

if [ -z "$(find "${tile_dir}/stemcell/" -maxdepth 1 -name '*.tgz' -print -quit)" ]; then
  echo "Error: Could not find stemcell at path '"${tile_dir}"/stemcell/*.tgz'"
  echo "Please download a stemcell and place it in '"${tile_dir}"/stemcell/'."
  exit 1
fi
if [ -z "$(find "${tile_dir}/releases/" -maxdepth 1 -name '*.tgz' -print -quit)" ]; then
  echo "Error: Could not find any releases at path '"${tile_dir}"/releases/*.tgz'"
  echo "Please download any required releases and place them in '"${tile_dir}"/releases/'."
  exit 1
fi

kiln bake \
  --icon "${tile_dir}/icon.png" \
  --instance-groups-directory "${tile_dir}/instance-groups" \
  --jobs-directory "${tile_dir}/jobs" \
  --properties-directory "${tile_dir}/properties" \
  --releases-directory "${tile_dir}/releases" \
  --stemcell-tarball "${tile_dir}"/stemcell/*.tgz \
  --metadata "${tile_dir}/base.yml" \
  --version "${version}" \
  --output-file "${tile_dir}/prometheus-${version}.pivotal"

echo "Success!"
echo "Created tile at '${tile_dir}/prometheus-${version}.pivotal'."
