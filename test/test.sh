#!/usr/bin/env bash

# Run all the tests.

# TODO: test -b option

rm -rf target/test.log

for t in test/test_?.sh; do
    echo $t | tee -a target/test.log
    mkdir -p target
    $t 2>>target/test.log
done
