import enchant
from enchant.checker import SpellChecker

def is_word (word):
    d = enchant.Dict("en_US")
    return d.check(word)

password = input('Enter password: ')
print (is_word (password))
