#!/usr/bin/env bash
set -euo pipefail
set -x
IFS=$'\n\t'

function build_target() {
  cachix use purescript
  [ -n "$CACHIX_SIGNING_KEY" ] && cachix push purescript --watch-store >cachix-push.log 2>&1 &
  nix-build ./default.nix -j2 -A "$1"
  #                        ^^
  # https://docs.travis-ci.com/user/reference/overview/

  sleep 10 # allow cachix finish uploading
  cat cachix-push.log
}

case "$1" in
"spago")
  if git diff-tree --no-commit-id --name-only -r "$TRAVIS_COMMIT" | grep -E 'default.nix$|spago/.*\.nix$'; then
    build spago
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
