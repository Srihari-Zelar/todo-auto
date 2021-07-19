#!/bin/bash
source components/common.sh

#Used export instead of service file
DOMAIN=ksrihari.online


OS_PREREQ

Head "Adding user"
useradd -m -s /bin/bash app &>>$LOG

Head "Changing directory to todo"
cd /home/app/

Head "Installing go language"
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local &>>$LOG
Stat $?

go version
~/.profile

Head "Exporting to path"
export PATH=$PATH:/usr/local/go/bin
Stat $?

source ~/.profile
mkdir -p ~/go/src &>>$LOG
Stat $?

cd  ~/go/src/
Stat $?

Head "Downloading Component"
rm -rf login
DOWNLOAD_COMPONENT
cd login/
Stat $?

Head "Installing go-dep"
apt update
apt install go-dep &>>$LOG
go get &>>$LOG
go build &>>$LOG
Stat $?

Head "pass the EndPoints in Service File"
sed -i -e "s/USERS_ENDPOINT/users.ksrihari.online:8080/" systemd.service
Stat $?

Head "Setup the systemd Service"
mv systemd.service /etc/systemd/system/login.service &>>$LOG
systemctl daemon-reload && systemctl start login && systemctl enable login &>>$LOG
Stat $?