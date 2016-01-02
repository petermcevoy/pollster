#!/bin/bash

echo "restarting service"
ssh -t peter@mlinux.duckdns.org 'sudo systemctl stop pollster; sudo systemctl start pollster; echo "done."'

