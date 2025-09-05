# Dockerfile
ARG RUBY_VERSION=3.2
FROM ruby:${RUBY_VERSION}

# Set working dir
WORKDIR /usr/src/app
COPY . .

# Install bundler and dependencies
RUN gem install bundler -v 2.4.22
RUN bundle install


# Default command runs tests
ENTRYPOINT ["./entrypoint.sh"]
