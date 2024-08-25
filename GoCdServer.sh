source CommonFile.sh
su - gocd -c 'rm -r -f /tmp/go-server'

Heading "Install Java"
dnf install java-17-openjdk.x86_64 -y
STAT $?

Heading "Add User"
id gocd
if [ $? -ne 0 ]; then
  useradd gocd
fi
STAT $?

Heading "Create Gocd Directory and change ownership"
mkdir /gocd/
chown gocd:gocd /gocd
STAT $?

Heading "Download Gocd Server"
curl -L -o /tmp/go-server-23.5.0-18179.zip  https://download.gocd.org/binaries/23.5.0-18179/generic/go-server-23.5.0-18179.zip
STAT $?

Heading "Unzip downloaded file using above created user"
su - gocd -c 'unzip /tmp/go-server-23.5.0-18179.zip'
STAT $?

Heading "Move unarchived file to gocd direcctory"
cd /home/gocd
mv mv go-server-23.5.0 /gocd/
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