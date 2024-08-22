dnf install java-17-openjdk.x86_64 -y
useradd go
curl -L -o /tmp/go-server-23.5.0-18179.zip  https://download.gocd.org/binaries/23.5.0-18179/generic/go-server-23.5.0-18179.zip
su - gocd -c 'unzip /tmp/go-server-23.5.0-18179.zip'
cp gocd-server.service /etc/systemd/system/gocd-server.service
systemctl daemon-reload
systemctl enable gocd-server
systemctl start gocd-server