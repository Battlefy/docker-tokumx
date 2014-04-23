FROM dockerfile/ubuntu

RUN echo never > /sys/kernel/mm/transparent_hugepage/enabled
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key 505A7412
RUN echo "deb [arch=amd64] http://s3.amazonaws.com/tokumx-debs $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/tokumx.list
RUN apt-get update
RUN apt-get install -y tokumx
RUN sed -i'' -e '/logpath/d' /etc/tokumx.conf

EXPOSE 27017
CMD ["--config", "/etc/tokumx.conf"]
ENTRYPOINT ["/usr/bin/mongod"]
