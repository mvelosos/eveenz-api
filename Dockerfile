FROM ruby:2.6.3-slim

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
build-essential nodejs libpq-dev imagemagick git-all
 
ENV INSTALL_PATH /party-api

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile ./

ENV BUNDLE_PATH /api-gems

COPY . .