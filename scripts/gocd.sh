#/bin/bash
echo "deb https://download.gocd.org /" | sudo tee /etc/apt/sources.list.d/gocd.list
curl https://download.gocd.org/GOCD-GPG-KEY.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install go-server go-agent
dpkg -s go-agent | grep Status
bash multi-go-agent.sh
sudo usermod -aG sudo go
sudo usermod -aG docker go
sudo bash set-sudo-user.sh go
sudo systemctl start go-server

