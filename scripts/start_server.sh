#!/bin/bash
sudo pip3 install virtualenv
cd /home/ec2-user/app
virtualenv environment
source environment/bin/activate

sudo pip3 install -r requirements.txt
# sudo apt-get -y install supervisor
# sudo unlink /var/run/supervisor.sock
sudo unlink /tmp/supervisor.sock

sudo unlink /var/run/supervisor.sock
python src/app.py
# supervisord -c supervisord.conf