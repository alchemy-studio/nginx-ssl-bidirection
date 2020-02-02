# 基于nginx的「ssl双向握手」测试服务容器

## 架构图

![](https://raw.githubusercontent.com/alchemy-studio/nginx-ssl-bidirection/master/arch.png)

## 下载image

```bash
$ docker pull alchemystudio/nginx-ssl-bidirection
```

## 手工编译容器

```bash
$ docker build --no-cache . 
```

## 手工启动容器

```bash
$ docker run -it -p 443:443 alchemystudio/nginx-ssl-bidirection sh
```

进入容器shell后启动`nginx`：

```bash
root# nginx
```

在host宿主访问服务：

```bash
$ curl --cacert /cert/server.crt --cert /cert/client.crt --key /cert/client.key https://localhost
```

## 自动启动容器和服务

```bash
$ docker-compose pull
```

```bash
$ docker-compose up
```

```bash
$ docker cp nginx-ssl-bidirection_nginx_1:/cert/server.crt .
```

```bash
$ docker cp nginx-ssl-bidirection_nginx_1:/cert/client.crt .
```

```bash
$ docker cp nginx-ssl-bidirection_nginx_1:/cert/client.key .
```

```bash
$ curl --cacert ./server.crt --cert ./client.crt --key ./client.key https://localhost
```

![](https://raw.githubusercontent.com/alchemy-studio/nginx-ssl-bidirection/master/66981580629445_.pic_hd.jpg)

## 用到本容器的文章

* [HTTPS的双向认证（一）](http://weinan.io/2020/02/01/ssl.html)
* [HTTPS的双向认证（二）](http://weinan.io/2020/02/02/ssl.html)
