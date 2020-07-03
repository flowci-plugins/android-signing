import sys
import json
import os
from flowci import client, domain

SecretName = client.GetVar('SIGN_SECRET')

api = client.Client()
secret = api.getCredential(SecretName)

if secret is None:
    sys.exit('unable to load secret ' + SecretName)

try:
    keyStoreName = secret['keyStoreFileName']
    path = api.downloadSecretFile(SecretName, keyStoreName)

    if path is None:
        sys.exit('unable to load keystore file' + keyStoreName)

    print(path) # key path
    print(secret['keyStorePassword']['data'])  # ks pw
    print(secret['keyAlias']) # key alias
    print(secret['keyPassword']['data']) # key pw
except:
    sys.exit('invalid secret')




