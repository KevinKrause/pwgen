Simple Python based password generator inspired by the nice dictionary based password generator that was included in macOS/MacOS X before Catalina.

The passwords are generated from two dictionary words, separated by a special character and a two digit number. One of the words starts with a capital letter. Which one, as well as the order of special character and number, is random.
The two dictionary words are of equal length or differ in length by one character, e.g. a  15 character password uses two 6 letter words plus 2 digits and a special char, a 16 character password is composed of one 6 and one 7 letter word plus 2 digits and a special char.

The list of special characters, the default number of generated passwords, and their default length can be configured in the script.

The word list is extracted from 
https://www.oxfordlearnersdictionaries.com/external/pdf/wordlists/oxford-3000-5000/American_Oxford_3000.pdf and https://www.oxfordlearnersdictionaries.com/external/pdf/wordlists/oxford-3000-5000/American_Oxford_5000.pdf
The lists have been combined and sorted. Duplicates and non 7bit ASCII characters as well as hyphenated compound words have been removed or replaced.

Please note that the word list is based on the 5000 most frequent words in American English and thus probably contains words that might be considered offensive alone or in certain combinations.
It is up to the user's consideration which generated passwords are deemed appropriate for use.

Usage:

pwgen.py --> outputs a list with the default number of passwords of the default length

pwgen.py -l <length> --> change length of generated passwords
pwgen.py -n <number> --> change the number of generated passwords
Long options are available as well: pwgen.py --length 22 --number 10

Sample Output:

Central&91twelve
Hostile01=soccer
Undergo*21ground
Social61&charity
profit84;Witness

You can use the report_frequency.py script to find out how many words of each length are present in the word list. With the current word list, words with 6 or 7 chars occur most often, so passwords with a length of 15 to 17 characters have the best entropy.

With a password length of 15 chars, there are 773 * 773 * 100 * 21 = 1,254,810,900 possible passwords
(773 six letter words in the current word list, number 00-99, and one of 21 special characters)


You can try a web based version at https://krau.se/pwgen/ or deploy it yourself as a CGI script. See clone.sh for a primitive script to deploy pwgen on your own web server.

WARNING: clone.sh DELETES FILES IN THE CURRENT DIRECTORY. It tries to be smart and should bail when the current directory is not empty, but THERE IS NO GUARANTEE THAT THIS ALWAYS WORKS CORRECTLY. REVIEW clone.sh AND PROCEED AT YOUR OWN RISK!

Here's an example snippet to include in your Apache2 config:

<Directory "/var/www/htdocs/pwgen">
		SetHandler cgi-script
		Options ExecCGI
		Order deny,allow
		Allow from all
		DirectoryIndex pwgen.py
		<LimitExcept GET OPTIONS>
				Deny from all
		</LimitExcept>
		<Files clone.sh>
				Deny from all
		</Files>
</Directory>

You'll have to figure out yourself how to do this on Nginx. Should be fairly trivial, though.