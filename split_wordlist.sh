#!/usr/bin/env bash

# Splits a wordlist into individual files per word length

set -e

mkdir words
for WORD in $( cat words.txt ); do
  LENGTH=$( echo -n "$WORD" | wc -c )
  FILENAME=$(printf '%02d' $LENGTH).txt
  echo "$WORD" >> words/"$FILENAME"
done
