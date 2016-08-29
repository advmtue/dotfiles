#!/usr/bin/python
### Script to parse the jsondata from i3-msg

import json;
import sys;

inputData = "";

for line in sys.stdin:
    inputData = inputData + line


jsonData = json.loads(inputData)

for workspace in jsonData:
    newformat = "|num:" + str(workspace["num"])
    newformat += "|name:" + workspace["name"]
    newformat += "|focused:" + str(workspace["focused"])
    newformat += "|output:" + workspace["output"]
    newformat += "\n"
    sys.stdout.write(newformat)
