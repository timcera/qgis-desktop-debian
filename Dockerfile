FROM debian:jessie
MAINTAINER Tim Cera <tim@cerazone.net>

RUN echo "deb     http://qgis.org/debian jessie main" >> /etc/apt/sources.list
RUN gpg --keyserver keyserver.ubuntu.com --recv 3FF5FFCAD71472C4
RUN gpg --export --armor 3FF5FFCAD71472C4 | apt-key add -

RUN    apt-get -y update

RUN    apt-get install -y \
           gdal-bin \
           python-gdal \
    && apt-get install -y --force-yes \
           qgis \
    && apt-get clean \
    && apt-get purge \
    && chmod -R a+w /usr/lib/x86_64-linux-gnu/qt4/plugins/designer/ \
    && chmod -R a+w /usr/lib/python2.7/dist-packages/PyQt4/uic/widget-plugins/ 

# Called when the Docker image is started in the container
ADD start.sh /start.sh
RUN chmod 0755 /start.sh

CMD /start.sh
