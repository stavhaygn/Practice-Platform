#! /usr/bin/env bash

setup() {
    export DEBIAN_FRONTEND=noninteractive
    apt-get install -y nmap hashcat python3-pip vim 
    apt-get autoremove
    pip install pycryptodome

    cd /home/packer
    git clone https://github.com/stavhaygn/challenges.git
    chown -R packer:packer /home/packer/challenges

    cd /home/packer/challenges/0810/scan_me_1
    docker-compose up -d

    cd /home/packer/challenges/0810/scan_me_2
    docker-compose up -d

    echo "172.29.0.100 scan1.macacahub.tw" >> /etc/hosts
    echo "172.30.0.100 scan2.macacahub.tw" >> /etc/hosts

    cd /home/packer/challenges/0811/CVE-2015-3306
    docker pull debian:jessie
    docker build -t vuln/cve-2015-3306 .

    cd /home/packer/challenges/0811/nginx-nodejs-redis
    docker-compose up -d
    docker-compose down
}

setup
