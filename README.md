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
7. 
