set -x
mkdir -p /cert
chown nginx /cert
cd /cert

# 服务端证书
openssl req \
    -new \
    -newkey rsa:4096 \
    -days 365 \
    -nodes \
    -x509 \
    -subj "/C=CN/ST=Beijing/L=Beijing/O=Personal/CN=localhost" \
    -keyout server.key \
    -out server.crt

# 客户端的根证书，用于给各个客户端的证书签名
openssl req \
    -new \
    -newkey rsa:4096 \
    -days 365 \
    -nodes \
    -x509 \
    -subj "/C=CN/ST=Beijing/L=Beijing/O=Personal/CN=ca" \
    -keyout ca.key \
    -out ca.crt

# 创建一个客户端证书，后续`curl`可以作为「客户端」使用起来
openssl genrsa -out client.key 4096
# .csr证书和.crt证书里面的格式内容都是一样的，只不过`.csr`的扩展名一般代表这张证书准备签名
openssl req -new -key client.key -out client.csr -subj "/C=CN/ST=Beijing/L=Beijing/O=Personal/CN=client"

# 用根证书给客户端证书签名
openssl x509 -req -days 360 -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt

chown -R nginx .

# fixme: 不知道这个srl文件是怎么产生的
rm -rf /cert/ca.srl

cd /etc/nginx/
sed -ie '/http {/r/root/nginx-ssl.conf' nginx.conf
cat /etc/nginx/nginx.conf

mkdir -p /etc/nginx/html/localhost
touch /etc/nginx/html/localhost/index.html
echo "Hello, world!" > /etc/nginx/html/localhost/index.html

chown -R nginx /etc/nginx/html/
