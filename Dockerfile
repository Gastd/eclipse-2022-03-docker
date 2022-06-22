FROM ubuntu:20.04
MAINTAINER Gastd <gabriel.araujo.5000@gmail.com>

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    bison \
    git \
    gperf \
    lib32gcc1 \
    # lib32bz2-1.0 \
    # lib32ncurses5 \
    lib32stdc++6 \
    lib32z1 \
    libc6-i386 \
    libxml2-utils \
    make \
    zip \
    apt-utils

COPY ./jdk-18_linux-x64_bin.deb /
RUN echo $(ls -1 /)
RUN apt-get install -y /jdk-18_linux-x64_bin.deb
RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-18/bin/java 1
RUN update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-18/bin/javac 1
RUN update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk-18/bin/jar 1
RUN update-alternatives --config java
RUN update-alternatives --config javac
RUN update-alternatives --config jar

ENV JAVA_HOME=/usr/lib/jvm/jdk-18
ENV J2SDKDIR=/usr/lib/jvm/jdk-18
ENV J2REDIR=/usr/lib/jvm/jdk-18
ENV PATH=$PATH:/usr/lib/jvm/jdk-18/bin:/usr/lib/jvm/jdk-18/db/bin
ENV JAVA_HOME=/usr/lib/jvm/jdk-18
ENV DERBY_HOME=/usr/lib/jvm/jdk-18/db

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update && apt-get install -y software-properties-common && \
    # add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    # echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y libxext-dev libxrender-dev libxtst-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Install libgtk as a separate step so that we can share the layer above with
# the netbeans image
RUN apt-get update && apt-get install -y libgtk2.0-0 libcanberra-gtk-module wget libswt-gtk-4-java

RUN wget http://www.mirrorservice.org/sites/download.eclipse.org/eclipseMirror/technology/epp/downloads/release/2022-03/R/eclipse-dsl-2022-03-R-linux-gtk-x86_64.tar.gz -O /tmp/eclipse.tar.gz -q && \
    echo 'Installing eclipse' && \
    tar -xf /tmp/eclipse.tar.gz -C /opt && \
    rm /tmp/eclipse.tar.gz

RUN echo $(ls -1 /opt/eclipse)
# ADD run /opt/eclipse/eclipse

# RUN mkdir -p /etc/sudoers.d/
# RUN touch /etc/sudoers.d/developer

# RUN chmod +x /opt/eclipse/eclipse && \
#     mkdir -p /home/developer && \
#     # mkdir -p /etc/sudoers.d/developer && \
#     echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
#     echo "developer:x:1000:" >> /etc/group && \
#     echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
#     chmod 0440 /etc/sudoers.d/developer && \
#     chown developer:developer -R /home/developer && \
#     chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo

# USER developer
# ENV HOME /home/developer
# WORKDIR /home/developer
ENV GDK_SYNCHRONIZE=1
# CMD /usr/bin/bash
CMD /opt/eclipse/eclipse
# echo "-Djava.library.path=/usr/lib/jvm/jdk-18/" >> /etc/eclipse.ini