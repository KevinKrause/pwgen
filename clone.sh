#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

FINDARGS=(-maxdepth 1 -not -name . -not -name .. -not -name 'clone.sh' -not -name 'pwgen.py' -not -name 'words.txt')

if [ -e .git ]; then
  echo "There's a .git directory here. Let's not do something stupid. Exiting."
  exit 1
fi

if [ $( find . ${FINDARGS[@]} | wc -l ) -gt 0 ]; then
  echo "There are other files around. Please start in an empty directory. Exiting."
  exit 1
fi

rm -f clone.sh pwgen.py words.txt

git init
git remote add origin https://github.com/KevinKrause/pwgen.git
git fetch
git checkout -t origin/master

find . ${FINDARGS[@]} -print0 | xargs -0 rm -r
