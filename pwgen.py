#!/usr/bin/env python3

# TODO: add turbo/low memory mode using pre-counted files from words/*.txt

from random import seed
from random import randint
from argparse import ArgumentParser

config = {
    "password_length": 18,
    "iterations": 5,
    "password_minlength": 10, # Should not be lower than 7 (2 char word + 2 digits + 1 special char + 2 char word)
    "password_maxlength": 30, # Should not be higher than 30 as there are few long words > 13 chars, resulting in low entropy
    "specialchars": '!@#$%^&*()-=+;:<>,./?'
}

def get_word(wordlist):
    i = randint(0, len(wordlist) - 1)
    return wordlist[i].lower()

parser = ArgumentParser()
parser.add_argument(
    "-l",
    "--length",
    dest="pwlength",
    type=int,
    default = config["password_length"],
    help="Password length",
    choices = range(config["password_minlength"], config["password_maxlength"] + 1)
)
parser.add_argument(
    "-n",
    "--number",
    dest="pwcount",
    type=int,
    default = config["iterations"],
    help="Number of passwords to generate"
)
args = parser.parse_args()

pwlength = args.pwlength
pwcount  = args.pwcount

# Load entire word list into separate lists by character count
file = open("words.txt", "r")
lines = {}
while True:
    line = file.readline()
    if not line:
        break
    line = line.rstrip()
    linelength = len(line)
    if not linelength in lines:
        lines[linelength] = []
    lines[linelength].append(line)
file.close()

words_total_length = pwlength - 3 # leave room for special char + 2 digits

seed()

for i in range(0, pwcount):
    # Recipe for pw construction: word + special char + 2 digits + word
    #                         or: word + 2 digits + special char + word
    # One of the words starts with a capital letter, the other doesn't
    # Both words are either the same length, or one is 1 char shorter
    # In this case, put the shorter word randomly to front or back
    first_word_length = round((words_total_length / 2) + (randint(0,1) / 10))
    parts = []
    parts.append(get_word(lines[first_word_length]))
    parts.append(get_word(lines[words_total_length - first_word_length]))
    specialchar = get_word(config["specialchars"])
    digits = str(randint(0, 9)) + str(randint(0, 9))

    # One word gets an uppercase first letter
    i = randint(0, 1)
    parts[i] = parts[i][0].upper() + parts[i][1:]

    # Special char comes before or after number
    if randint(0, 1) == 1:
        password = parts[0] + specialchar + digits + parts[1]
    else:
        password = parts[0] + digits + specialchar + parts[1]

    print(password)
