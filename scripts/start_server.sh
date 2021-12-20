#!/bin/bash
cd /home/ec2-user/app
source environment/bin/activate
sudo apt-get -y install supervisor
supervisord -c supervisord.conf