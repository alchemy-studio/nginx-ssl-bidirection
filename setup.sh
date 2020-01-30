#!/bin/sh

# supervisor setup
#!/bin/sh
mkdir -p /etc/supervisor.d/

mkdir -p /root/logs
touch /root/logs/supervisord.log
touch /root/logs/err.log
touch /root/logs/out.log

cat > /etc/supervisor.d/default.ini <<EOF
[unix_http_server]
file=/run/supervisord.sock

[supervisord]
logfile=/root/logs/supervisord.log
loglevel=info
nodaemon=true
user=root

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///run/supervisord.sock ; use a unix:// URL  for a unix socket

[inet_http_server]
port=0.0.0.0:9001
[program:web]
# nginx must run in forground to be controlled by supervisor
command=/usr/sbin/nginx -g 'daemon off;'
stderr_logfile=/root/logs/err.log
stdout_logfile=/root/logs/out.log
EOF