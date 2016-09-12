#!/bin/bash

bundle check || bundle install

bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake assets:precompile

bundle exec rackup faye.ru -s thin -E production &
bundle exec rails s -b 0.0.0.0
#bundle exec unicorn_rails -c config/unicorn.rb