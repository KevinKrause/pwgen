#!/usr/bin/env python3

import os.path
import sys

WORDFILE = "words.txt"
OUTDIR   = "words/"

if os.path.exists(OUTDIR):
    print(OUTDIR + " exists, please move or remove before using")
    sys.exit()

os.mkdir(OUTDIR)

file = open(WORDFILE, "r")
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

for linelength in lines:
    outfile = open(OUTDIR + str("{:02d}".format(linelength)) + ".txt", "w")
    for word in lines[linelength]:
        outfile.write(word + "\n")
    outfile.close()
