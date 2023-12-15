#!/bin/bash

docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images)
docker login -u yash1508 -p Yash@0408
docker build -t yash1508/server .
docker push yash1508/server

ssh admin@54.226.88.136 -i /var/lib/jenkins/workspace/key.pem << EOF


#Docker Installation Started
sudo apt-get update
ip a
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
#Installing docker packages
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
#docker installaton working check
#sudo docker run hello-world

sudo chmod 666 /var/run/docker.socks
#sudo usermod -aG docker jenkins
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images)
docker login -u yash1508 -p Yash@0408
docker pull yash1508/server
sleep 25s
docker run --name webservice -d -p 80:80 yash1508/server
EOF
