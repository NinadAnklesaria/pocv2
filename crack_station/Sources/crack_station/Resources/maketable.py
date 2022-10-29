import hashlib
import json


d = {}

x=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','0','1','2','3','4','5','6','7','8','9']

i=0
j=0
for j in x:
    for i in x:
        variable= i+''+j
        #print(variable)
        
        hash_object = hashlib.sha1(variable.encode()) 
        pbHash = hash_object.hexdigest()
        #print(pbHash)
        d[pbHash] = variable 
    

print("Saved")

with open('data.json', 'w') as fp:
    json.dump(d, fp)