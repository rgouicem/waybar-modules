#!/usr/bin/env python3

import shutil, sys, json

ret = {
    "text": "<b>no device</b>",
    "device": "<b>no device</b>",
    "total": "0",
    "used": "0",
    "free": "0",
    "usage": "0",
    "tooltip":"",
    "class":"ko"
}

if len(sys.argv) is not 2:
    print(json.dumps(ret))
    exit(1)

try:
    # data = (total, used, free)
    data = shutil.disk_usage(sys.argv[1])
    to_giga = lambda x: (x[0] // 1000000000,
                         x[1] // 1000000000,
                         x[2] // 1000000000)
    data = to_giga(data)
    ret["total"] = str(data[0])
    ret["used"] = str(data[1])
    ret["free"] = str(data[2])
    usage = data[1] / data[0]
    ret["usage"] = str(usage)
    ret["device"] = "<b>{}</b>".format(sys.argv[1])
    ret["text"] = "<b>{}:</b> {}G".format(sys.argv[1], ret["free"])
    ret["class"] = "{}".format("ok" if usage < 0.9 else "ko")
    print(json.dumps(ret))
    exit(0)
    
except FileNotFoundError:
    ret["text"] = "<b>device not found</b>"
    ret["device"] = "<b>device not found</b>"
    print(json.dumps(ret))
    exit(1)
