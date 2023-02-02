docker run -it \
    --net=host \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --device=/dev/dri:/dev/dri \
    --privileged \
    --name="b1_dev"\
    b1_dev
