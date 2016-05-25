#!/usr/bin/python
# findout the md5 hash from anaconda website

import urllib2
# from BeautifulSoup import BeautifulSoup
# or if you're using BeautifulSoup4:
from bs4 import BeautifulSoup

url = 'https://repo.continuum.io/archive/'

soup = BeautifulSoup(urllib2.urlopen(url).read(), 'lxml')

table_all = soup.find("table")
filename = 'Anaconda2-4.0.0-Linux-x86_64.sh'
md5hash = ''
count = 0
for row in table_all.findAll('tr'):
    count += 1
    col = row.findAll('td')

    if col and len(col) > 3 and col[0].string.strip() == filename:
        md5hash = col[3].string.strip()
        break

print md5hash
print "Scanned through {} rows".format(count)
