set -x
mkdir -p /cert
chown nginx /cert
cd /cert

openssl req \
    -new \
    -newkey rsa:4096 \
    -days 365 \
    -nodes \
    -x509 \
    -subj "/C=CN/ST=Beijing/L=Beijing/O=Personal/CN=localhost" \
    -keyout localhost.key \
    -out localhost.crt
chown -R nginx .

cd /etc/nginx/
sed -ie '/http {/r/root/nginx-ssl.conf' nginx.conf
cat /etc/nginx/nginx.conf

mkdir -p /etc/nginx/html/localhost
touch /etc/nginx/html/localhost/index.html
echo "Hello, world!" > /etc/nginx/html/localhost/index.html

chown -R nginx /etc/nginx/html/
