Simple Python based password generator inspired by the nice dictionary based password generator that was included in macOS/MacOS X before Catalina.

The password is generated from two dictionary words, separated by a special character and a two digit number. One of the words starts with a capital letter. Which one, as well as the order of special character and number, is random.

The list of special characters, the default number of generated passwords, and their length can be configured in the script.

The dictionary is extracted from https://www.oxfordlearnersdictionaries.com/external/pdf/wordlists/oxford-3000-5000/American_Oxford_5000.pdf

Usage:

pwgen.py --> outputs a list with the default number of passwords of the default length

pwgen.py -l <length> --> change length of generated passwords
pwgen.py -n <number> --> change the number of generated passwords
Long options are available as well: pwgen.py --length 22 --number 10

Sample Output:

Amusing41*shocking
formerly64;Mandate
Homeland&76reverse
compile61#Stimulus
feminist70-Venture
