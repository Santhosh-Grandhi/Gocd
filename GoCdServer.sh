dnf install java-17-openjdk.x86_64 -y
useradd gocd
curl -L -o /tmp/go-server.zip  https://download.gocd.org/binaries/23.5.0-18179/generic/go-server.zip
su - gocd -c 'unzip /tmp/go-server.zip'
cp gocd-server.service /etc/systemd/system/gocd-server.service
systemctl daemon-reload
systemctl enable gocd-server
systemctl start gocd-server