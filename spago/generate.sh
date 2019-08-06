#!/usr/bin/env bash
set -euo pipefail
set -x
IFS=$'\n\t'

# https://github.com/spacchetti/spago/releases
declare -a versions=(
  "0.9.0.0"
  "0.8.5.0"
  "0.8.4.0"
  "0.8.3.0"
  "0.8.1.0"
  "0.8.0.0"
)

function fill() {
  nix-prefetch-git --quiet https://github.com/spacchetti/spago "$1" >spago-src.json
  git clone -q -c advice.detachedHead=false --depth 1 -b "$1" https://github.com/spacchetti/spago "$1"
  stack-to-nix --output . --stack-yaml "$1/stack.yaml"
  rm -rf default.nix "$1"
  nixfmt ./*.nix
  local src
  src="  \
  src = with builtins.fromJSON (builtins.readFile ./spago-src.json); \
    builtins.fetchTarball { \
    name = \"spago-$v\"; \
    url = \"\${url}/archive/\${rev}.tar.gz\"; \
    inherit sha256; };"
  sed -i "s/^  src.*/$(echo "$src" | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/g" spago.nix
  nixfmt ./*.nix
}

for v in "${versions[@]}"; do
  [ -d "$v" ] && rm -rf "$v"
  mkdir "$v"
  (cd "$v" && fill "$v")
done
