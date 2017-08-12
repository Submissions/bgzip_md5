#!/usr/bin/env bash

ROOT="$(pwd)"
TARGET="$ROOT"/target/test_1

rm -rf "$TARGET"
mkdir -p "$TARGET"

cd "$TARGET"/
echo hello world > input
md5sum input > expected.md5

cd "$ROOT"
./bgzip_md5.py "$TARGET"/input

cd "$TARGET"/
gzip -cd input.gz | diff input -
diff expected.md5 input.md5
