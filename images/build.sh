#!/usr/bin/env bash

cd images

for file in *.mmd; do
    mmdc --output "${file%.mmd}.svg" -i "$file"
done
