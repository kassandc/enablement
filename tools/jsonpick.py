#!/usr/bin/env python3
import sys, json

try:
    data = json.load(sys.stdin)
    for key in sys.argv[1:]:
        print(data[key])
except Exception:
    sys.exit(1)

