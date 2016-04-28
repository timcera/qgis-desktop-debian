FROM debian:jessie
MAINTAINER Tim Cera <tim@cerazone.net>

RUN echo "deb     http://qgis.org/debian jessie main" >> /etc/apt/sources.list
RUN gpg --keyserver keyserver.ubuntu.com --recv 3FF5FFCAD71472C4
RUN gpg --export --armor 3FF5FFCAD71472C4 | apt-key add -

RUN    apt-get -y update

RUN    apt-get install -y \
           unixodbc-bin \
           tdsodbc \
           libmyodbc

RUN    apt-get install -y \
           odbc-postgresql

RUN    apt-get install -y \
           libnetcdff5 \
           libnetcdfc7 \
           libnetcdfc++4 \
           libcf0 \
           libjasper-runtime

# This is here to try and split up the layers into smaller chunks.
# I chose this to hopefully get most of qt4 installed in this layer.
RUN    apt-get install -y \
           libqt4-sql-mysql \
           qt4-designer \
           qt4-linguist-tools \
           qt4-qmake \
           python-qscintilla2 \
           python-qt4 \
           python-qt4-sql \
           python-sip

RUN    apt-get install -y \
           gdal-bin

RUN    apt-get install -y \
           python-gdal

RUN    apt-get install -y \
           python-cairo \
           python-chardet \
           python-dateutil \
           python-egenix-mxdatetime \
           python-egenix-mxtools \
           python-glade2 \
           python-gobject-2 \
           python-gtk2 \
           python-httplib2 \
           python-imaging \
           python-jinja2 \
           python-markupsafe \
           python-matplotlib \
           python-matplotlib-data \
           python-mock \
           python-nose \
           python-pil \
           python-pkg-resources \
           python-psycopg2 \
           python-pygments \
           python-pyparsing \
           python-pyspatialite \
           python-six \
           python-support \
           python-talloc \
           python-tk \
           python-tz \
           python-yaml

RUN    apt-get install -y --force-yes \
           qgis

RUN    apt-get clean \
    && apt-get purge \
    && chmod -R a+w /usr/lib/x86_64-linux-gnu/qt4/plugins/designer/ \
    && chmod -R a+w /usr/lib/python2.7/dist-packages/PyQt4/uic/widget-plugins/ 

# Called when the Docker image is started in the container
ADD start.sh /start.sh
RUN chmod 0755 /start.sh

CMD /start.sh
