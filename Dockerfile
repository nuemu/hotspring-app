FROM ruby:2.7.4

RUN apt-get update -qq && \
    apt-get install -y build-essential \
            libpq-dev \
            nodejs \
            npm \
            yarn \
            postgresql-client \
            vim

RUN npm install --global yarn

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle config set path 'vendor/bundle'
RUN gem install bundler