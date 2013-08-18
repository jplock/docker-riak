# DOCKER-VERSION 0.5.3
# VERSION        0.1

FROM ubuntu

MAINTAINER Justin Plock <jplock@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y -q install curl

RUN curl http://apt.basho.com/gpg/basho.apt.key | apt-key add -
RUN echo "deb http://apt.basho.com precise main" > /etc/apt/sources.list.d/basho.list
RUN apt-get update
RUN apt-get -y -q install riak || true
RUN sed 's/127.0.0.1/0.0.0.0/' -i /etc/riak/app.config

EXPOSE 8098 8087

CMD /usr/sbin/riak start && tail -f /var/log/riak/console.log
