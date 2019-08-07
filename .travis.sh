#!/usr/bin/env bash
set -euo pipefail
set -x
IFS=$'\n\t'

function build_target() {
  cachix use purescript
  # Fail if the signing key isn't defined, cos the whole point of this build
  # is to hydrate the cache
  [ -n "$CACHIX_SIGNING_KEY" ] && cachix push purescript --watch-store >cachix-push.log 2>&1 &

  nix-build ./default.nix -j auto -A "$1"

  sleep 10 # allow cachix finish uploading
  cat cachix-push.log
}

case "$1" in
"purs")
  if git diff-tree --no-commit-id --name-only -r "$TRAVIS_COMMIT" | grep -E 'default.nix$|purs/.*\.nix$'; then
    build_target purs.v0_13_2 # FIXME
  else
    echo 'Nothing to do'
    exit 0
  fi
  ;;
"spago")
  if git diff-tree --no-commit-id --name-only -r "$TRAVIS_COMMIT" | grep -E 'default.nix$|spago/.*\.nix$'; then
    build_target spago
  else
    echo 'Nothing to do'
    exit 0
  fi
  ;;

"")
  echo 'missing target executable argument'
  echo 'usage: .travis.sh [EXE]'
  exit 1
  ;;
esac
