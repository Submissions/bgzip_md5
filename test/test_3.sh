#!/usr/bin/env bash

ROOT="$(pwd)"
TARGET="$ROOT"/target/test_3

rm -rf "$TARGET"
mkdir -p "$TARGET"/{in,out}

cd "$TARGET"/in
echo hello world a > input_a
echo hello world b > input_b
md5sum input_a > expected_a.md5
md5sum input_b > expected_b.md5

cd "$ROOT"
./bgzip_md5.py -bv -d "$TARGET"/out "$TARGET"/in/input_?

cd "$TARGET"/
for x in a b; do
    gzip -cd out/input_${x}.gz | diff in/input_${x} -
    diff in/expected_${x}.md5 out/input_${x}.md5
done
