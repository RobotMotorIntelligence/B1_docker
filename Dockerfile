FROM osrf/ros:melodic-desktop-full

ARG SSH_PRIVATE_KEY
ARG SSH_PUBLIC_KEY

# Minimal setup
RUN apt-get update \
    && apt-get install -y locales lsb-release
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg-reconfigure locales

RUN apt-get update && \
    apt-get install -y \
    git \
    openssh-server \
    libmysqlclient-dev \
    vim

# Authorize SSH Host
RUN mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh && \
    touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com > /root/.ssh/known_hosts
# Add the keys and set permissions
RUN echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa && \
    echo "$SSH_PUBLIC_KEY" > /root/.ssh/id_rsa.pub && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa.pub

# Install dependencies
RUN apt install -y liblcm-dev
WORKDIR /home/b1_ws/src
RUN git clone -b v3.8.3 https://github.com/unitreerobotics/unitree_legged_sdk.git
RUN cd unitree_legged_sdk
WORKDIR /home/b1_ws/src/unitree_legged_sdk
RUN mkdir build && cd build && cmake .. && make -j$(nproc)
WORKDIR /home/b1_ws/src
RUN git clone -b v3.8.0 https://github.com/unitreerobotics/unitree_ros_to_real.git
RUN git clone -b master https://github.com/unitreerobotics/unitree_ros.git
WORKDIR /home/b1_ws
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; catkin_make'

RUN apt install -y ros-melodic-joint-state-publisher*

# personal setup 
RUN echo "source /home/b1_ws/devel/setup.bash" >> ~/.bashrc
RUN touch ~/.inputrc
RUN echo "\"\e[B\": history-search-forward" >> ~/.inputrc
RUN echo "\"\e[A\": history-search-backward" >> ~/.inputrc
RUN apt-get install -y bash-completion
