MAX_KEY = 26

def encrypt (plaintext, key): 
    translated = ''
    for i in plaintext: 
        if i.isalpha():
            #from 97 to 122
            pos = ord(i)
            new_pos = (pos - 97 + key) % MAX_KEY + 97
            translated += unichr(new_pos)
        else:
            translated += i
    return translated

plaintext = input ("Enter plain text: ")
key = input ("Enter key [0,26]: ")
print (encrypt(plaintext, key))
