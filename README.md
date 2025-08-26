# hh_mapviz

## Overview
This repository contains the files and instructions for installing a working mapviz with docker file for ARM architecture. This branch `main` only contains read me.  

1. Install mapviz package in ROS
```
sudo apt-get install ros-$ROS_DISTRO-mapviz \
                       ros-$ROS_DISTRO-mapviz-plugins \
                       ros-$ROS_DISTRO-tile-map \
                       ros-$ROS_DISTRO-multires-image
```

Refer to [official mapviz repo for troubleshooting](https://swri-robotics.github.io/mapviz/)

2. Locally clone this repository
```
git clone git@github.com:alimuratov/hh_mapviz.git
```
3. Go in this directory
```
cd hh_mapviz
```
4. Switch to branch `master`
5. Build the docker image
```
  sudo docker build --platform linux/arm64 -t my-mapproxy:arm64 .
```
6. Run the docker image
```
sudo docker run -d -p 8080:8080 --name mapproxy-service -v ~/hh_mapviz:/mapproxy my-mapproxy:arm64
```
7. Verify that it is working properly
    [link to map](http://127.0.0.1:8080/demo/)

8. Open mapviz
``` roslaunch mapviz mapviz.launch ```
9. Click add and select tile_map in mapviz, In the new tile_map, change source to custom wmts source
10. Change base url: to `http://localhost:8080/wmts/gm_layer/webmercator/{level}/{x}/{y}.png`
11. To add gps fix, add navsat topic and make sure gps_rtk driver is running.
12. In config file, edit the location to roughly where you want.


