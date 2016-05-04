MAX_KEY = 26

def encrypt (plaintext, key): 
    translated = ''
    for i in plaintext: 
        if i.isalpha():
            #from 97 to 122
            pos = ord(i)
            offset = 97
            if i.isupper(): 
                offset = 65
            new_pos = (pos - offset + key) % MAX_KEY + offset
            translated += unichr(new_pos)
        else:
            translated += i
    return translated

plaintext = input ("Enter plain text: ")
key = input ("Enter key [0,26]: ")
while key > 27 or key < 0:
    key = input ("Enter a valid key [0, 26]: ")
print (encrypt(plaintext, key))
