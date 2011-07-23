#!/bin/bash
cd /var/www/sites/pollster.mlinux.ath.cx/app
screen -A -m -d -S faye rackup faye.rb -s thin -E production