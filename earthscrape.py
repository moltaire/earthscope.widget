#!/usr/bin/python

import json
import urllib2
import os

# download the current earthview json file
html_con = urllib2.urlopen('https://earthview.withgoogle.com')
website = html_con.read()
html_con.close()
start = 'explore" href="'
end = '">Explore</a>'
url = website[website.index(start)+len(start):website.index(end)]

api_con = urllib2.urlopen('https://earthview.withgoogle.com/_api' + url + '.json')
api = api_con.read()
api_con.close()

with open('api.json', 'w') as api_file:
    api_file.write(api)

# load previously created json file into info dictionary
with open('api.json') as json_file:
    info = json.load(json_file)

# if country, region or url are missing, add blank fields
for key in ['country', 'region', 'url']:
    if not key in info:
        info[key] = ''

# write image_path to dictionary
info['image_path'] = info['photoUrl']

# give back json file
print json.dumps(info)
