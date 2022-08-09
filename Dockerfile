FROM ruby:3.1.1-slim
RUN apt-get update -qq
WORKDIR /leetcoder

RUN gem install leetcoder

ENTRYPOINT ["/bin/bash"]
