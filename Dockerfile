FROM ruby:2.7.4

RUN apt-get update -qq && \
    apt-get install -y build-essential \
            libpq-dev \
            nodejs \
            npm \
            yarn \
            postgresql-client

RUN npm install --global yarn
RUN yarn install

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle config set path 'vendor/bundle'
RUN bundle install