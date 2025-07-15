#!/bin/bash

sudo apt install python3-pip python3-dev libpq-dev -y

sudo pip3 install --upgrade pip

python3 -m pip install --upgrade pip

pip install etcd3

sudo pip install etcd3

pip install etcd3gw

sudo pip install etcd3gw

pip install patroni[etcd]

sudo pip install patroni[etcd]

pip install patroni[etcd]

pip install psycopg2

sudo pip install psycopg2

sudo mkdir -p /etc/patroni/

sudo chown -R  postgres:postgres /etc/patroni/

sudo nano /etc/patroni/patroni.yml

# Add the content to the patroni.yml file

sudo nano /etc/systemd/system/patroni.service

# Add the content to the patroni.service file

sudo systemctl daemon-reload

sudo systemctl restart patroni

sudo systemctl status patroni