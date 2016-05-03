MAX_KEY = 26

def decipher(ciphertext):
    for i in range(0, 26):
        plaintext = ''
        for j in range(0, len(ciphertext)):
            if ciphertext[j].isalpha():
                plaintext += 

ciphertext = input ("Enter ciphertext: ")
print (decipher(ciphertext))
