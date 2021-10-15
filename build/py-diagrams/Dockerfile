FROM python:3.9-slim

#---INSTALL REQUIREMENTS---
RUN     DEBIAN_FRONTEND=noninteractive apt-get update \
    &&  DEBIAN_FRONTEND=noninteractive apt-get install -y \
            graphviz \
    &&  pip3 install --upgrade pip

#---Install Tools---
RUN pip install diagrams
