FROM arm64v8/ubuntu:16.04

RUN apt-get -y update && apt-get install -y build-essential coreutils pkg-config cmake libglib2.0-dev libavcodec-dev libavformat-dev libswscale-dev libavresample-dev libfftw3-dev libgoogle-glog-dev libjpeg-dev libpng16-dev libjasper-dev libtiff5-dev libwebp-dev tzdata

# configure timezone
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

WORKDIR /tmp

# install eigen
COPY eigen-3.3.4.tar.gz /tmp/
RUN tar xzvf eigen-3.3.4.tar.gz
RUN mv Eigen /usr/include/aarch64-linux-gnu/

# install cpptoml
COPY cpptoml.h /usr/include/aarch64-linux-gnu/

# install dlib
COPY arm64/dlib-19.15-arm64.tar.gz /tmp/
RUN tar xzvf dlib-19.15-arm64.tar.gz
RUN mv dlib/include/dlib /usr/include/aarch64-linux-gnu/
RUN mv dlib/lib/libdlib.a /usr/lib/aarch64-linux-gnu/
RUN mv dlib/dlib.pc /usr/lib/aarch64-linux-gnu/pkgconfig/

# install ncnn
COPY arm64/ncnn-arm64.tar.gz /tmp/
RUN tar xzvf ncnn-arm64.tar.gz
RUN mv ncnn/include/ncnn /usr/include/aarch64-linux-gnu/
RUN mv ncnn/lib/libncnn.a /usr/lib/aarch64-linux-gnu/
RUN mv ncnn/ncnn.pc /usr/lib/aarch64-linux-gnu/pkgconfig/

# install tracker KCF
COPY arm64/tracker-kcf-arm64.tar.gz /tmp/
RUN tar xzvf tracker-kcf-arm64.tar.gz
RUN mv tracker-kcf/include/tracker /usr/include/aarch64-linux-gnu/
RUN mv tracker-kcf/lib/libtrackerKCF.a /usr/lib/aarch64-linux-gnu/
RUN mv tracker-kcf/tracker-kcf.pc /usr/lib/aarch64-linux-gnu/pkgconfig/

# install opencv
COPY arm64/opencv-3.4.2-arm64.tar.gz /tmp/
RUN tar xzvf opencv-3.4.2-arm64.tar.gz
RUN mv opencv/include/* /usr/include/
RUN mv opencv/lib/* /usr/lib/
RUN mv opencv/share/OpenCV /usr/share/
RUN mv opencv/opencv.pc /usr/lib/aarch64-linux-gnu/pkgconfig/

# install edge-tracker
#COPY edge-tracker-0.1.2.tar.gz /tmp/
#RUN tar xzvf edge-tracker-0.1.2.tar.gz
#RUN mkdir -p /tmp/edge-tracker-0.1.2/build
#WORKDIR /tmp/edge-tracker-0.1.2/build
#RUN cmake ..
#RUN make
#WORKDIR /tmp/edge-tracker-0.1.2
#RUN bin/export 32 64 70 80 90 100

RUN mkdir -p /tmp/edge-tracker
COPY arm64/edge-tracker /tmp/edge-tracker/
COPY arm64/wisdom /tmp/edge-tracker/

# copy dlib face model
COPY shape_predictor_68_face_landmarks.dat /tmp/edge-tracker

# entrypoint
#ENTRYPOINT bin/main
