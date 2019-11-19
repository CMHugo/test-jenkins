FROM ubuntu:18.04

MAINTAINER Hugo <cespedesmartinezhugo@gmail.com> 
ENV HOME /root

#instalacion de actualizaciones
RUN apt-get update && apt-get upgrade -y

#instalacion de python
RUN apt-get install python python-pip -y
RUN mkdir /opt/app
COPY src/main.py /opt/app/
COPY src/requirements.txt /opt/app
RUN pip install -r /opt/app/requirements.txt
COPY docker-entrypoint.sh /

EXPOSE 5000

#ejecutar la app
ENTRYPOINT "/docker-entrypoint.sh"
