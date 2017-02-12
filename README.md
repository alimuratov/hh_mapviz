# Google Maps Satellite + MapProxy

Run MapProxy in docker and serve Google Maps Satellite over WMTS protocol. 

## Getting the image


```
docker pull danielsnider/mapproxy
```

## Setup

Create the MapProxy configuration folder and yaml file. The cached map tiles will be written to `~/mapproxy/cache_data`.

```
mkdir ~/mapproxy/
cp ./mapproxy.yaml ~/mapproxy/
```

## Run 

Start the MapProxy server with `~/mapproxy` as a shared volume.

```
docker run -p 8080:8080 -d -t -v ~/mapproxy:/mapproxy danielsnider/mapproxy
```

Alternatively, running interactively will allow you experiment with MapProxy:

```
docker run -p 8080:8080 -it -v ~/mapproxy/:/mapproxy danielsnider/mapproxy bash
```

Note that the mapproxy containerised application will run as the user that owns the /mapproxy folder.

### Google Terms & Conditions

In 2013 there was [some discussion](http://gis.stackexchange.com/questions/56982/how-to-use-mapproxy-to-serve-wms-from-reprojected-google-maps-tiles) about Google's Terms & Conditions stating that you are only allowed to access the tiles through Google's API (ie. not MapProxy). I'm not aware if this is still the case.
