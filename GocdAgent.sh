source CommonFile.sh

Heading "Install Java"
dnf install java-17-openjdk.x86_64 -y
STAT $?

Heading "Add User"
id gocd
if [ $? -ne 0 ]; then
  useradd gocd
fi
STAT $?

Heading "Download Gocd agent"
curl -L -o /tmp/go-agent-23.5.0-18179.zip https://download.gocd.org/binaries/23.5.0-18179/generic/go-agent-23.5.0-18179.zip
STAT $?

Heading "Unzip content using gocd user"
su - gocd -c 'unzip /tmp/go-agent-23.5.0-18179.zip'
STAT $?

Heading "Copy Gocd Agent file"
cp gocd-agent.service /etc/systemd/system/gocd-agent.service
STAT $?

#Heading "Change User group"
#su - gocd
#STAT $?

Heading "Update GoCD server in configuration file wrapper-properties.conf with gocd server ip address."
su - gocd -c "sed -i 's/localhost/gocd.devoperations.online/' go-agent-23.5.0/wrapper-config/wrapper-properties.conf"
STAT $?

#Heading "Exit from gocd user"
#exit
#STAT $?

Heading "Reload Deamon"
systemctl daemon-reload
STAT $?

Heading "Enable and Start Service"
systemctl enable gocd-agent
systemctl start gocd-agent
STAT $?