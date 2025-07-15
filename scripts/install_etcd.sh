#!/bin/bash

#Install pre-built binaries

#Download the compressed archive file for your platform from Releases, choosing release v3.5.21 or later.

#Know your architecture 

dpkg --print-architecture

wget https://github.com/etcd-io/etcd/releases/download/v3.6.1/etcd-v3.6.1-linux-amd64.tar.gz

#https://github.com/etcd-io/etcd/releases/

#Disclaimer: etcd installations through OS package managers can deliver outdated versions since they are not being automatically maintained nor officially supported by etcd project. Therefore use OS packages with caution.

#Unpack the archive file. This results in a directory containing the binaries.

ls -lrt 

chmod 777 etcd-v3.6.1-linux-amd64.tar.gz

tar -xvf etcd-v3.6.1-linux-amd64.tar.gz 

rm -rf etcd-v3.6.1-linux-amd64.tar.gz

chmod -R 777 etcd-v3.6.1-linux-amd64

#Add the executable binaries to your path. For example, rename and/or move the binaries to a directory in your path (like /usr/local/bin), or add the directory created by the previous step to your path.
sudo mv etcd /usr/local/bin/

sudo mv etcdctl /usr/local/bin/

#From a shell, test that etcd is in your path:

etcd --version

#Create service file
sudo nano /etc/systemd/system/etcd.service

sudo systemctl daemon-reload

sudo systemctl start etcd.service

sudo systemctl status etcd.service

#Cluster setup

#To set up a cluster, you need to configure the initial cluster state and member information.
#This is typically done by creating a configuration file or passing command-line arguments to the etcd
#binaries when starting etcd. The configuration file can include details like the initial cluster state
#and member information, such as the names and addresses of the etcd nodes in the cluster       

#For example, you can create a configuration file named etcd.conf with the following content:

sudo nano /etc/default/etcd

etcdctl member list

etcdctl  endpoint status -w=table

etcdctl endpoint status --cluster -w=table

#To enable etcd to start on boot, run the following command:
sudo systemctl enable etcd.service

#You can check the status of the etcd service using:
sudo systemctl status etcd.service

