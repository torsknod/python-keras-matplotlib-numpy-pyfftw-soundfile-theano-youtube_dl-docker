FROM tensorflow/tensorflow:latest-gpu

ENV DEBIAN_FRONTEND noninteractive
RUN mkdir -p /usr/src/app && apt-get update && apt-get --install-suggests --yes dist-upgrade && apt-cache pkgnames python | egrep -i "^python-(numpy|pyfftw|soundfile|theano|keras|youtube.dl|matplotlib)$" | xargs apt-get --yes install \
    libfftw3-dev \
    liblapack-dev \
    youtube-dl

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip install -r requirements.txt

ONBUILD COPY requirements.txt /usr/src/app/
ONBUILD COPY . /usr/src/app

ONBUILD RUN pip install -r requirements.txt
