#!/usr/bin/python

import json
import urllib2
import os

# check if there is a next.json file, that has the next image in it
if os.path.isfile('earthscope.widget/next.json'):
    # rename this to this.json (overwriting existing this.json)
    os.system('mv earthscope.widget/next.json earthscope.widget/this.json')
else: # download the current earthview json file
    html_con = urllib2.urlopen('https://earthview.withgoogle.com')
    website = html_con.read()
    html_con.close()
    start = 'explore" href="'
    end = '">Explore</a>'
    url = website[website.index(start)+len(start):website.index(end)]

    api_con = urllib2.urlopen('https://earthview.withgoogle.com/_api' + url + '.json')
    this = api_con.read()
    api_con.close()

    with open('earthscope.widget/this.json', 'w') as api_file:
        api_file.write(this)

# load previously created json file into info dictionary
with open('earthscope.widget/this.json') as json_file:
    thisinfo = json.load(json_file)

# if country, region or url are missing, add blank fields
for key in ['country', 'region', 'url']:
    if not key in thisinfo:
        thisinfo[key] = ''

#download file here
f = urllib2.urlopen(thisinfo['photoUrl'])
# Open our local file for writing
with open('earthscope.widget/image.jpg', "wb") as local_file:
    local_file.write(f.read())
f.close()

#also save next json
api_con = urllib2.urlopen('https://earthview.withgoogle.com/' + thisinfo['nextApi'])
next = api_con.read()
api_con.close()
with open('earthscope.widget/next.json', 'w') as api_file:
    api_file.write(next)

# write image_path to dictionary
thisinfo['image_path'] = thisinfo['photoUrl']

# give back json file
print json.dumps(thisinfo)
