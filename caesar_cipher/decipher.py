import enchant
from enchant.checker import SpellChecker

MAX_KEY = 26

def decipher(ciphertext):
    checker = SpellChecker("en_US")
    best_key = -1
    least_num_errors = len(ciphertext)
    for i in range(0, 26):
        plaintext = ''
        for j in range(0, len(ciphertext)):
            if ciphertext[j].isalpha():
                pos = ord(ciphertext[j])
                offset = 97
                if ciphertext[j].isupper():
                    offset = 65
                new_pos = (pos - offset + 26 - i) % 26 + offset
                plaintext += unichr(new_pos)
            else:
                plaintext += ciphertext[j]
        checker.set_text(plaintext)
        num_errors = 0
        for err in checker:
            num_errors = num_errors + 1
        if num_errors < least_num_errors:
            least_num_errors = num_errors
            best_key = i
        words = plaintext.split()
        en_words = len(words) - num_errors
        print("%i: %s English words: %i" % (i, plaintext, en_words))
    return "%s %i" % ("The key is most likely: ", best_key)

ciphertext = input ("Enter ciphertext: ")
print (decipher(ciphertext))
