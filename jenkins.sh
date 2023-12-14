#!/bin/bash

#Java installaion
sudo apt update
sudo apt install fontconfig openjdk-17-jre -y
java -version

#long term support package release
sudo apt update
sudo apt install wget -y
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y




#Enable Jenkins
sudo systemctl enable jenkins

#Start Jenkins
sudo systemctl start jenkins

#Restart
#sudo systemctl restart jenkins

#Check Status
sudo systemctl status jenkins
