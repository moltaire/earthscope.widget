#!/usr/bin/python

import json
import os
from random import choice

# choose random file from image directory
files = [info for info in os.listdir('earthscrape.widget/images/') if info.endswith('.json')]
json_path = 'earthscrape.widget/images/' + choice(files)
image_path = json_path.split('.json')[0] + '.jpg'

# load json file into info dictionary
with open(json_path) as json_file:
    info = json.load(json_file)

# if country, region or url are missing, add blank fields
for key in ['country', 'region', 'url']:
    if not key in info:
        info[key] = ''

# write image_path to dictionary
info['image_path'] = image_path

# give back json file
print json.dumps(info)
