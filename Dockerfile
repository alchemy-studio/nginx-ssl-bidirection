FROM nginx
RUN apt-get update
RUN apt-get install -y openssl curl vim procps supervisor
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' > /etc/timezone
COPY setup.sh /root/
RUN sh /root/setup.sh
COPY gencert.sh /root/
COPY nginx-ssl.conf /root/
RUN sh /root/gencert.sh
COPY entrypoint.sh /root/




