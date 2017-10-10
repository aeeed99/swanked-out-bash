#!/bin/bash

eval spawn git credential-osxkeychain erase

set prompt ""
interact -o -nobuffer -re $prompt return
send "host=github.com\r"
interact send -o -nobuffer -re $prompt return
send "protocol=https\r"
interact send -o -nobuffer -re $prompt return
send "\r"
interact

# git credential-osxkeychain erase\r
# host=github.com\r
# protocol=https\r
# \r
