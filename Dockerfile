FROM ruby:3.2

LABEL maintainer="kvronin@gmail.com"

RUN apt-get update -qq && \
    apt-get install -y \
                    build-essential \
                    curl \
                    git \
                    libvips \
                    procps \
                    rsync \
                    wget

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
		wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
		apt-get update && \
		apt-get -y install postgresql-client-15


RUN echo "gem: --no-document" >> ~/.gemrc && \
    gem install bundler && \
    echo "set -o vi" >> ~/.bashrc && \
    apt-get -y install vim

COPY Gemfile* /usr/src/app/

WORKDIR /usr/src/app

RUN bundle install

COPY . /usr/src/app/

EXPOSE 3000
