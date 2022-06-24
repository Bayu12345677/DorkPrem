import sys, os
from googlesearch import search

def sysdork(query):
    jum = 0
    try:
        for hasil in search(query, tld="com", lang="en", num=200, start=0, stop=None, pause=0.1):
            print(hasil)
            jum += 1 
            if jum >= 200:
                break
    except:
        pass


sysdork(sys.argv[1])
