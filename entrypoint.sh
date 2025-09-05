#!/bin/bash
set -e

echo "Running tests on Ruby $(ruby -v) with Bundler $(bundle -v)"
bundle exec rake test
