FROM ruby:2.5
RUN mkdir /aoc
WORKDIR /aoc
COPY Gemfile Gemfile.lock /aoc/
RUN bundle install
COPY . /aoc