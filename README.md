docker-qgis-desktop-debian
==========================

Based very loosely on kartoza/qgis-desktop.  Instead of compiling, this image
is a "apt-get install" from http://qgis.org/debian.

This also includes installation of gdal-bin and python-gdal.

Much of the documentation below is edited from kartoza/qgis-desktop.  Just want
to acknowledge the source material, but any problems with this documentation you
should contact me.  

Note this is still experimental and probably does not represent
the most optimal way to do this. Current limitations:

* Qt4 theme is not carried over nicely
* Uses xhost + which is not ideal since it allows all remote
  hosts to display windows on your X display (probably not
  an issue if you are on a local network).


# Getting the image

## Use the docker repository:

```
docker pull timcera/qgis-desktop-debian
```

Required Manual Installation
----------------------------
To run a container create a script similar to below:

```
#!/bin/sh

xhost +

# Users home is mounted as home
# --rm will remove the container as soon as it ends
docker run --rm \
    -i -t \
    -v ${HOME}:/home/${USER} \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    timcera/qgis-desktop:master

xhost -

```
The above is the content of run-qgis-master-in-docker.sh so you can just
```
./run-qgis-master-in-docker.sh
```


```
sudo cp run-qgis-master-in-docker.sh /usr/local/bin
sudo cp QGIS-2.8.Docker.desktop /usr/share/applications/
sudo cp qgis-icon-60x60.png /usr/local
```

If you follow this approach you will need to create the 
application launcher yourself, manually. Consult the sources in this
repository for more details on how to do that.


Follow the instructions above to create a desktop shortcut. Then, when you
click on the QGIS icon this script will run and start the container. 

Note that your home directory will be mounted in the container and thus
accessible to QGIS. If you want other directories to be available, just add
then to run-qgis-in-docker.sh with -v flags. 

If QGIS crashes or hangs it might leave an orphan docker process running. If
you see the process with 
```
docker ps
```
Then run 
```
docker stop <process id or container name>
```
Else run 
```
docker ps -a
```
then
```
docker rm <process id or container name>



-----------

Tim Sutton (tim@kartoza.com)
July 2014
