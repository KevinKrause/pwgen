#!/usr/bin/env python3

'''Outputs the frequency of word lengths in the configured text file'''

import os

wordsdir = os.path.dirname(os.path.realpath(__file__))
with open(wordsdir + "/words.txt", "r", encoding='utf-8') as file:
    lines = {}
    while True:
        line = file.readline()
        if not line:
            break
        line = line.rstrip()
        linelength = len(line)
        if not linelength in lines:
            lines[linelength] = 0
        lines[linelength] += 1
    file.close()

sorted_lines = dict(sorted(lines.items()))

print("Length Count")
for length, counter in sorted_lines.items():
    print(str(length).rjust(6, " ") + str(counter).rjust(6, " "))
