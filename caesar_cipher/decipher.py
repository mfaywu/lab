MAX_KEY = 26

def decipher(ciphertext):
    for i in range(0, 26):
        plaintext = ''
        for j in range(0, len(ciphertext)):
            if ciphertext[j].isalpha():
                pos = ord(ciphertext[j])
                new_pos = (pos - 97 + 26 - i) % 26 + 97
                plaintext += unichr(new_pos)
            else:
                plaintext += ciphertext[j]
        print("%i: %s" % (i, plaintext))
    return

ciphertext = input ("Enter ciphertext: ")
print (decipher(ciphertext))
