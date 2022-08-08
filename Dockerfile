# syntax=docker/dockerfile:1
FROM ruby:3.1.1
RUN apt-get update -qq
WORKDIR /leetcoder

RUN gem install leetcoder

ENTRYPOINT ["/bin/bash"]
