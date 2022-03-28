Simple Python based password generator inspired by the nice dictionary based password generator that was included in macOS/MacOS X before Catalina.

Word list taken from https://www-personal.umich.edu/~jlawler/wordlist.html, slightly cleansed and split into separate files by character count.
You can prepare your own word list with the split_wordlist.py script.

Usage:

pwgen.py --> generates a list of passwords of the default length. Default Number of generated PWs and their length can be configured in the script

pwgen.py -l <length> --> change length of generated passwords
pwgen.py -n <number> --> change the number of generated passwords
Long options are available as well: pwgen.py --length 22 --number 10

Sample Output:

spying20-Ofmake
dispel91+Purism
pledge>81Cooing
vessel49?Mammon
Sphere-76foible