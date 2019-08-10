#!/usr/bin/env bash
set -euo pipefail
set -x
IFS=$'\n\t'

# https://gitlab.com/joneshf/purty/-/releases
declare -a versions=(
  "4.5.1"
  "4.5.0"
)

function fill() {
  nix-prefetch-git --quiet https://gitlab.com/joneshf/purty "$1" >purty-src.json
  git clone -q -c advice.detachedHead=false --depth 1 -b "$1" https://gitlab.com/joneshf/purty "$1"
  stack-to-nix --output . --stack-yaml "$1/stack.yaml"
  rm -rf default.nix "$1"
  nixfmt ./*.nix
  local src
  src="  \
  src = with builtins.fromJSON (builtins.readFile ./purty-src.json); \
    builtins.fetchTarball { \
    name = \"purty-$v\"; \
    url = \"\${url}/-/archive/\${rev}.tar.gz\"; \
    inherit sha256; };"
  sed -i "s/^  src.*/$(echo "$src" | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/g" purty.nix
  nixfmt ./*.nix
}

for v in "${versions[@]}"; do
  [ -d "$v" ] && rm -rf "$v"
  mkdir "$v"
  (cd "$v" && fill "$v")
done
