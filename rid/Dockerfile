FROM ruby:2.4.2-alpine


#  Timezone
#-----------------------------------------------
ENV TIMEZONE Asia/Tokyo

RUN apk add --no-cache -U tzdata \
  && ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime


#  Library
#-----------------------------------------------
RUN apk add --no-cache -U \
    bash \
    ca-certificates \
    cmake \
    coreutils \
    g++ \
    git \
    icu-dev \
    less \
    libc-dev \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    make \
    ncurses-dev \
    nodejs \
    openssh-client \
    openssl-dev \
    postgresql-dev \
    zlib-dev


#  App
#-----------------------------------------------
WORKDIR /app
