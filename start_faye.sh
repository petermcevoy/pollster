#!/bin/bash
cd /var/www/sites/pollster.mlinux.ath.cx/pollster
screen -A -m -d -S faye rackup faye.ru -s thin -E production