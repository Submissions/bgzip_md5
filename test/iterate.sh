#!/usr/bin/env bash

clear
rm -rf target
pycodestyle bgzip_md5.py
./test/test.sh
date
