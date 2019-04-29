# DebCCPP

Debian Stable based image for C & C++ builds, including cmake

## Build

```
./build.sh
```

## Run

```
cp run.template.sh run.sh
#
# fix paths in run.sh
#
./run.sh
#
# or with default settings
#
docker run -ti debccpp:latest
```

> forked from madduci/docker-linux-cpp
