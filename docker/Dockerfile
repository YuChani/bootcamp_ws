# Ubuntu 22.04 + ROS 2 Humble + OpenCV (source build, CPU)

FROM ros:humble-ros-base

SHELL ["/bin/bash", "-c"]
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Etc/UTC
ENV TZ=${TZ}
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
ARG OPENCV_VERSION=4.8.0

# dependency
RUN apt-get update && apt-get install -y --no-install-recommends \
    git build-essential sudo cmake ninja-build pkg-config \
    python3-pip python3-dev \
    libeigen3-dev libboost-all-dev libjsoncpp-dev \
    libgl1-mesa-dev mesa-utils libglfw3-dev libglm-dev libopengl-dev \
    libjpeg-dev libpng-dev libtiff-dev \
    libavcodec-dev libavformat-dev libswscale-dev libswresample-dev libssl-dev \
    libtbb-dev libgtk-3-dev libdc1394-dev libopenexr-dev \
    libusb-1.0-0-dev liblz4-dev libgtest-dev \
    libopenni-dev libgdal-dev libosmesa6-dev \
    curl wget unzip zip locales gnupg2 lsb-release \
    libsuitesparse-dev \
    libglu1-mesa-dev \
    freeglut3-dev \
    qtbase5-dev \
    libqglviewer-dev-qt5 \
    libabsl-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libsuitesparse-dev \
 && rm -rf /var/lib/apt/lists/*

# opencv
RUN set -eux; \
    mkdir -p /opencv && cd /opencv && \
    wget https://github.com/opencv/opencv/archive/refs/tags/${OPENCV_VERSION}.zip -O opencv.zip && \
    wget https://github.com/opencv/opencv_contrib/archive/refs/tags/${OPENCV_VERSION}.zip -O contrib.zip && \
    unzip opencv.zip && unzip contrib.zip && rm -f opencv.zip contrib.zip && \
    mkdir -p /opencv/opencv-${OPENCV_VERSION}/build && cd /opencv/opencv-${OPENCV_VERSION}/build && \
    cmake -G Ninja .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DOPENCV_EXTRA_MODULES_PATH=/opencv/opencv_contrib-${OPENCV_VERSION}/modules \
      -DOPENCV_GENERATE_PKGCONFIG=ON \
      -DBUILD_EXAMPLES=OFF -DBUILD_TESTS=OFF -DBUILD_DOCS=OFF \
      -DWITH_TBB=ON -DWITH_GTK=ON -DWITH_FFMPEG=ON && \
    ninja -j"$(nproc)" && ninja install && ldconfig && \
    rm -rf /opencv

# ---- git clone ----
RUN mkdir -p /root/bootcamp/src && cd /root/bootcamp/src && \
    git clone https://github.com/RainerKuemmerle/g2o.git && \
    git clone https://ceres-solver.googlesource.com/ceres-solver

# setting
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc

# work directory
WORKDIR /root/bootcamp

# OSRF use normal_entrypoint
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]

