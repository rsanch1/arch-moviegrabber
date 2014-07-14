FROM phusion/baseimage:0.9.11
MAINTAINER binhex
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US en_US.UTF-8

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Correct user and group uid/guid
RUN usermod -u 99 nobody && \
    usermod -g 100 nobody && \
    usermod -d /config nobody

ADD sources.list /etc/apt/
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install p7zip-full

# install application
#####################

# make destination folder
RUN mkdir -p /opt/moviegrabber

# download zip from github - url zip name is different to destination
ADD https://github.com/binhex/moviegrabber/archive/master.zip /opt/moviegrabber/moviegrabber-master.zip

# unzip to folder
RUN 7z x /opt/moviegrabber/moviegrabber-master.zip

# move unzipped contents back to moviegrabber root
RUN mv /opt/moviegrabber/moviegrabber-master/ /opt/moviegrabber/

# remove files and folders
RUN rm /opt/moviegrabber/moviegrabber-master.zip
RUN rm -rf /opt/moviegrabber/moviegrabber-master/

# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME ['/config']

# map /data to host defined data path (used to store data from app)
VOLUME ['/data']

# map /media to host defined media path (used to read/write to media library)
VOLUME ['/media']

# expose port for http
EXPOSE 9191

# set permissions
#################

# change owner
RUN chown -R nobody:users /opt/moviegrabber

# set permissions
RUN chmod -R 775 /opt/moviegrabber

# add conf file
###############

ADD moviegrabber.conf /etc/supervisor/conf.d/moviegrabber.conf

# cleanup
#########
# remove temporary files
RUN rm -rf /tmp/*

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]
