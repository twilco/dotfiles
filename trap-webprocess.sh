#!/bin/bash
# Returns control to GDB when running WebKit.
# https://stackoverflow.com/a/6442197/2421349
kill -TRAP $(ps ax | awk '$5 ~ /WebKitWebProcess/ {print $1}')
