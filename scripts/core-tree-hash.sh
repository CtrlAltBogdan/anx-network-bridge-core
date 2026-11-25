#!/usr/bin/env sh
# Prints the SHA-256 of the ANX Network Bridge Core source tree: every file under src/ of the given directory,
# hashed individually and listed in byte order of their paths. Used by core.lock in the platform repositories.
set -eu
dir=${1:-.}
cd "$dir"
find src -type f | LC_ALL=C sort | while IFS= read -r f; do printf '%s  %s\n' "$(sha256sum "$f" | cut -c1-64)" "$f"; done | sha256sum | cut -c1-64
