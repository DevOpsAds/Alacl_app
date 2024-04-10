#execulte esse codigo no para gerar_novas secrets_key

import secrets
import string

def generate_secret_key(length):
    return ''.join(secrets.choice(string.ascii_letters + string.digits + '!@#$%^&*(-_=+)') for _ in range(length))

if __name__ == "__main__":
    key_length = 10  # Defina o comprimento desejado da chave
    secret_key = generate_secret_key(key_length)
    print("Chave secreta:", secret_key)
