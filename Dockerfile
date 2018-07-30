FROM arm64v8/debian:stable-slim

RUN apt-get -y update && apt-get install -y cmake git build-essential git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libfftw3-dev