FROM ubuntu:jammy as ub

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get -y dist-upgrade &&  apt-get -y install fakeroot tzdata locales sudo dumb-init && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN ln -fs /usr/share/zoneinfo/Europe/Prague /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen && rm -f /usr/bin/sudo ; ln -s /usr/bin/fakeroot /usr/bin/sudo

RUN useradd --uid 1000 -s /bin/bash ubuntu && mkdir /home/ubuntu && cp -r /etc/skel/. /home/ubuntu && chown -R 1000:1000 /home/ubuntu

FROM scratch

COPY --chown=1000:1000 --from=ub / /

USER 1000

RUN mkdir -p /usr/share/glvnd/egl_vendor.d /usr/share/egl/egl_external_platform.d /etc/vulkan/implicit_layer.d /etc/vulkan/icd.d 

RUN echo 'Acquire::http::Proxy "http://proxy.ics.muni.cz:3128";' > /etc/apt/apt.conf.d/90-aptproxy

WORKDIR /home/ubuntu

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

