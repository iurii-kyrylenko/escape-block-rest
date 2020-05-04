FROM ubuntu:16.04

# Install curl
RUN apt-get update && apt-get upgrade
RUN apt-get install -y curl

# Install stack:
RUN curl -sSL https://get.haskellstack.org/ | sh
