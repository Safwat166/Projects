from Crypto.Cipher import AES
import os

# Define the absolute path
base_path = r"D:\Digital Design Verfication\Week 8\AES\Python_code"

# Read the data and key from the file
with open(os.path.join(base_path, 'key.txt'), 'r') as file:
    data_hex = file.readline().strip()  # Read the data hex string
    key_hex = file.readline().strip()   # Read the key hex string

data = bytes.fromhex(data_hex)
key = bytes.fromhex(key_hex)

cipher = AES.new(key, AES.MODE_ECB)
ciphertext = cipher.encrypt(data)

# Write the encrypted data to the output file
with open(os.path.join(base_path, 'output.txt'), 'w') as file:
    file.write(ciphertext.hex())
