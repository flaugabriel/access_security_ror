#!/bin/bash
gem install bundle
bundle check || bundle install
rm tmp/pids/server.pid
gem install mailcatcher
mailcatcher
bundle exec rails s -p 3030 -b 0.0.0.0