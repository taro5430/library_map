FROM ruby:3.0.0

RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -  \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn

WORKDIR /library_map

COPY Gemfile /library_map/Gemfile
COPY Gemfile.lock /library_map/Gemfile.lock

RUN bundle install

RUN mkdir -p tmp/sockets
