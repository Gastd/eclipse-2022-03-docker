xhost +
docker run -ti --rm \
           -e DISPLAY=$DISPLAY \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v `pwd`/.eclipse-docker:/home/root \
           -v `pwd`:/workspace \
eclipse-2022-03:latest
