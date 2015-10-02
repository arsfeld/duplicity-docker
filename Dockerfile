FROM debian:8

MAINTAINER Julien Iguchi-Cartigny <kartoch@gmail.com>

# Install packages required
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python-pip python-dev wget python-setuptools rsync librsync-dev \
    lftp ncftp librsync1 
#    python-setuptools git python-pip python-dev bzr rsync wget \
#    build-essential librsync1 ncftp lftp librsync-dev openstack-dashboard && \
#    rm -rf /var/lib/apt/lists/*

# Install the pyhton requirements
#ADD requirements.txt /opt/
#RUN pip install --upgrade --requirement /opt/requirements.txt

# Download and install duplicity
RUN export VERSION=0.7.05 && \
   cd /tmp/ && \
   wget https://code.launchpad.net/duplicity/0.7-series/$VERSION/+download/duplicity-$VERSION.tar.gz && \
   cd /opt/ && \
   tar xzvf /tmp/duplicity-$VERSION.tar.gz && \
   rm /tmp/duplicity-$VERSION.tar.gz && \
   cd duplicity-$VERSION && \
   ./setup.py install

# Set the ENTRYPOINT
ENTRYPOINT [ "/usr/local/bin/duplicity" ]
