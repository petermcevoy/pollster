#!/bin/bash

echo "precomiling assets"
ssh -t git@mlinux.duckdns.org 'cd /var/www/pollster.it/app; bundle exec rake environment RAILS_ENV=production assets:precompile'

