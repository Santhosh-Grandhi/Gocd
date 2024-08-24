source CommonFile.sh
su - gocd -c 'rm -r -f go-server'

Heading "Install Java"
dnf install java-17-openjdk.x86_64 -y
STAT $?

Heading "Add User"
id gocd
if [ $? -ne 0 ]; then
  useradd gocd
fi
STAT $?

Heading "Download Gocd Server"
curl -L -o /tmp/go-server.zip  https://download.gocd.org/binaries/23.5.0-18179/generic/go-server.zip
STAT $?

Heading "Unzip downloaded file using above created user"
su - gocd -c 'unzip /tmp/go-server.zip'
STAT $?

Heading "Copy Gocd Service file"
cp gocd-server.service /etc/systemd/system/gocd-server.service
STAT $?

Heading "Reload Deamon"
systemctl daemon-reload
STAT $?

Heading "Enable and Start Service"
systemctl enable gocd-server
systemctl start gocd-server
STAT $?