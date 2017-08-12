#!/usr/bin/env bash

ROOT="$(pwd)"
TARGET="$ROOT"/target/test_4

rm -rf "$TARGET"
mkdir -p "$TARGET"

cd "$TARGET"
echo hello world a > input_a
echo hello world b > input_b
md5sum input_a > input_a.md5
md5sum input_a > input_b.md5  # Deliberate error!
bgzip input_?

cd "$ROOT"
./bgzip_md5.py -cv "$TARGET"/input_a.gz  2> "$TARGET"/test_4a.log
if [[ ! $? ]]; then
    echo "got unexpected error; see test_4a.log"
fi

./bgzip_md5.py -cv "$TARGET"/input_b.gz  2> "$TARGET"/test_4b.log
if [[ $? ]]; then
    echo "did not get expected error; see test_4b.log"
fi

./bgzip_md5.py -cv "$TARGET"/input_?.gz  2> "$TARGET"/test_4ab.log
if [[ $? ]]; then
    echo got zero result in test_4ab
fi
