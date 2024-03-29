#!/usr/bin/env bash

# TODO: use a nix-shell shebang to make sure all the dependencies are present

set -euo pipefail
set -x
IFS=$'\n\t'

declare -a versions=(
  "v0.13.0"
  "v0.13.2"
)

function fill() {
  nix-prefetch-git --quiet https://github.com/purescript/purescript "$1" >purescript-src.json
  git clone -q -c advice.detachedHead=false --depth 1 -b "$1" https://github.com/purescript/purescript "$1"
  stack-to-nix --output . --stack-yaml "$1/stack.yaml"
  rm -rf default.nix "$1"
  nixfmt ./*.nix
  local src
  src="  \
  src = with builtins.fromJSON (builtins.readFile ./purescript-src.json); \
    builtins.fetchTarball { \
    name = \"purescript-$v\"; \
    url = \"\${url}/archive/\${rev}.tar.gz\"; \
    inherit sha256; };"
  sed -i "s/^  src.*/$(echo "$src" | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/g" purescript.nix
  nixfmt ./*.nix
}

for v in "${versions[@]}"; do
  [ -d "$v" ] && rm -rf "$v"
  mkdir "$v"
  (cd "$v" && fill "$v")
done
