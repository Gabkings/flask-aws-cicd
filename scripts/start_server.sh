#!/bin/bash
cd /home/ec2-user/app
source environment/bin/activate
sudo pip3 install -r requirements.txt
# sudo apt-get -y install supervisor
sudo unlink /var/run/supervisor.sock
python src/app.py
# supervisord -c supervisord.conf