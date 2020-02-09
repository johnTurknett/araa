FROM ruby:2.6.5
WORKDIR /app
COPY . .
RUN bundle install --jobs=20 --retry=5
