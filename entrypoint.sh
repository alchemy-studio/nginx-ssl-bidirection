#!/bin/sh
set -x
# supervisor start
supervisord -c /etc/supervisor.d/default.ini
ps -ef
curl -v -k https://localhost
