FROM ubuntu:bionic as ub

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get -y dist-upgrade &&  apt-get -y install fakeroot tzdata locales sudo && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN rm -f /usr/bin/sudo; ln -sr /usr/bin/fakeroot /usr/bin/sudo
RUN rm -f /bin/sh && ln -sr /bin/bash /bin/sh

RUN ln -fs /usr/share/zoneinfo/Europe/Prague /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen

FROM scratch

COPY --chown=1000:1000 --from=ub / /

USER 1000

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

