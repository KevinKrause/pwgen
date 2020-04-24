#!/usr/bin/env bash

set -e

# Defaults
PWLENGTH=15
ITERATIONS=5

# Argument parsing lifted from https://medium.com/@Drew_Stokes/bash-argument-parsing-54f3b81a6a8f
# N.B.: this causes the script to hang when there's no value after a named argument
while (( "$#" )); do
  case "$1" in
    -l|--length)
      PWLENGTH=$2
      shift 2
      ;;
    -n|--number)
      ITERATIONS=$2
      shift 2
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

# Config
PW_MINLENGTH=7 # Should not be lower than 7 (2 char word + 2 digits + 1 special char + 2 char word)
PW_MAXLENGTH=43
SPECIALCHARS='!@#$%^&*()-=+;:<>,./?'
SPECIALCHARS_LENGTH=$( echo -n $SPECIALCHARS | wc -c )

# Sanity checks
if [ $PWLENGTH -lt $PW_MINLENGTH ]; then
  echo "Password must be at least $PW_MINLENGTH chars long"
  exit
fi

if [ $PWLENGTH -gt $PW_MAXLENGTH ]; then
  echo "Password must not be longer than $PW_MAXLENGTH chars"
  exit
fi

# Determine the length of the two dictionary words
WORDS_TOTAL_LENGTH=$(( $PWLENGTH - 3 ))
WORDLENGTH1=$(( WORDS_TOTAL_LENGTH / 2))
if [[ $(( $WORDS_TOTAL_LENGTH % 2 )) == 0 ]]; then
  WORDLENGTH2=$WORDLENGTH1
else
  WORDLENGTH2=$(( WORDLENGTH1 + 1 ))
fi

WORDSFILE1=$( printf "words/%02d" $WORDLENGTH1).txt
WORDSFILE2=$( printf "words/%02d" $WORDLENGTH2).txt

for ((I=1; I<=ITERATIONS; I++)); do # Sequences à la {1..9} don't take variables, so we use a good old for loop here
  # $RANDOM only goes up to 32768, but some files contain more lines than that
  # So we generate a larger random number
  WORDPOS1=$(( $RANDOM * $RANDOM % $( cat $WORDSFILE1 | wc -l ) ))  
  WORD1=$( sed -n "${WORDPOS1}p" $WORDSFILE1 )

  WORDPOS2=$(( $RANDOM * $RANDOM % $( cat $WORDSFILE2 | wc -l ) ))
  WORD2=$( sed -n "${WORDPOS2}p" $WORDSFILE2 )

  CHARPOS=$(( $RANDOM % SPECIALCHARS_LENGTH + 1 ))
  CHAR=$( echo -n $SPECIALCHARS | cut -c"$CHARPOS" )

  DIGITS=$( printf "%05d" $RANDOM | cut -c4-5 )

  if [[ $(( $RANDOM % 2 )) == 0 ]]; then
    echo $WORD1$CHAR$DIGITS$WORD2
  else
    echo $WORD1$DIGITS$CHAR$WORD2
  fi
done
