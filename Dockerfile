FROM debian:jessie
MAINTAINER Tim Cera <tim@cerazone.net>

RUN echo "deb     http://qgis.org/debian jessie main" >> /etc/apt/sources.list
RUN gpg --keyserver keyserver.ubuntu.com --recv DD45F6C3
RUN gpg --export --armor DD45F6C3 | apt-key add -

RUN    apt-get -y update \
    && apt-get install -y \
           gdal-bin \
           python-gdal \
    && apt-get install -y --force-yes \
           qgis \
    && apt-get clean \
    && apt-get purge \
    && chmod -R a+w /usr/lib/x86_64-linux-gnu/qt4/plugins/designer/ \
    && chmod -R a+w /usr/lib/python2.7/dist-packages/PyQt4/uic/widget-plugins/ 

# Called on first run of docker
ADD start.sh /start.sh
RUN chmod 0755 /start.sh

CMD /start.sh
