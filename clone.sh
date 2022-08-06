#!/usr/bin/env bash

if [ -e .git ]; then
  echo "There's a .git directory here - let's not do something stupid. Exiting."
  exit
fi

rm clone.sh pwgen.py words.txt

git init
git remote add origin https://github.com/KevinKrause/pwgen.git
git fetch
git checkout -t origin/master

find . \
  -maxdepth 1 \
  -not -name . \
  -not -name .. \
  -not -name 'clone.sh' \
  -not -name 'pwgen.py' \
  -not -name 'words.txt' \
  -print0 \
  | xargs -0 rm -r

