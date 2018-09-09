FROM ubuntu:xenial

RUN apt-get update -y && apt-get install -y apt-transport-https curl -y

# Crystal
RUN curl -sL "https://keybase.io/crystal/pgp_keys.asc" | apt-key add -
RUN echo "deb https://dist.crystal-lang.org/apt crystal main" | tee /etc/apt/sources.list.d/crystal.list

RUN apt-get update -y 

RUN apt-get install -y \
  libbsd-dev \
  libedit-dev \
  libevent-core-2.0-5 \
  libevent-dev \
  libevent-extra-2.0-5 \
  libevent-openssl-2.0-5 \
  libevent-pthreads-2.0-5 \
  libgmp-dev \
  libgmpxx4ldbl \
  libssl-dev \
  libxml2-dev \
  libyaml-dev \
  libreadline-dev \
  automake \
  libtool \
  git \
  llvm \
  libpcre3-dev \
  build-essential \
  libasound2-dev \
  mesa-common-dev \
  libx11-dev \
  libxrandr-dev \
  libxi-dev \
  xorg-dev \
  libgl1-mesa-dev \
  libglu1-mesa-dev \
  crystal

COPY crystal /crystal
RUN cd /crystal && make deps && mkdir -p /usr/lib/crystal/ext && cp src/ext/libcrystal.a /usr/lib/crystal/ext/libcrystal.a
RUN apt-get install -y libgc-dev

RUN mkdir /app
WORKDIR /app
CMD crystal
