#!/bin/sh
set -x
# supervisor start
supervisord -c /etc/supervisor.d/default.ini
ps -ef
curl --cacert /cert/server.crt --cert /cert/client.crt --key /cert/client.key https://localhost

