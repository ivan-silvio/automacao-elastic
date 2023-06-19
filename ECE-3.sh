
#1

sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://download.docker.com/linux/centos/7/x86_64/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/centos/gpg
EOF

sudo yum -y update

sudo yum install -y epel-release

sudo yum-config-manager --enable repository CentOS-7-Base  CentOS-7 - Extras CentOS-7-Updates

yum install -y yum-utils

sudo yum clean all

sudo yum makecache

3

sudo yum install -y docker-ce-20.10* docker-ce-cli-20.10* containerd.io-1.5.*

#yum install git  wget 

sudo yum install -y python3 

#sudo yum install python-pip

sudo yum install -y vim vi

pip3 install --upgrade pip

pip3 install ansible


4

sudo systemctl stop docker

cat <<EOF | sudo tee -a /etc/sysctl.conf
# Required by Elasticsearch 5.0 and later
vm.max_map_count=262144
# enable forwarding so the Docker networking works as expected
net.ipv4.ip_forward=1
# Decrease the maximum number of TCP retransmissions to 5 as recommended for Elasticsearch TCP retransmission timeout.
# See https://www.elastic.co/guide/en/elasticsearch/reference/current/system-config-tcpretries.html
net.ipv4.tcp_retries2=5
# Make sure the host doesn't swap too early
vm.swappiness=1
EOF


5

RHEL/CentOS 7:

sudo sysctl -p
sudo systemctl restart network

6

#The default limit for number of processes is too low. Remove it and rely on the kernel limit instead (for RHEL/CentOS 7 only).


sudo rm /etc/security/limits.d/20-nproc.conf

7

sudo usermod -aG docker $USER


8

echo "exclude=docker-ce" | sudo tee -a /etc/yum.conf

9

mkdir /etc/systemd/system/docker.service.d/


sudo tee /etc/systemd/system/docker.service.d/docker.conf <<-'EOF'
[Unit]
Description=Docker Service
After=multi-user.target

[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --data-root /mnt/data/docker --storage-driver=overlay2 --bip=172.17.42.1/16 --raw-logs --icc=false
EOF


#Update the /etc/systemd/system/docker.service.d/docker.conf file. If the file path and file do not exist, create them.


10


sudo adduser elastic

sudo usermod -a -G wheel elastic


sudo usermod -a -G docker elastic

11




sudo mkdir /mnt/data

#lssudo mkdir /mnt/data/elastic/ 

sudo chmod -R 777 /mnt/data/


12

sudo systemctl start docker


sudo systemctl enable docker

13



runuser -l elastic -c "bash <(curl -fsSL https://download.elastic.co/cloud/elastic-cloud-enterprise.sh) install --force --coordinator-host $meucluster --roles-token $MY_TOKEN --roles "director,coordinator" --availability-zone POC-03 --memory-settings '{"runner":{"xms":"1G","xmx":"1G"},"zookeeper":{"xms":"4G","xmx":"4G"},"director":{"xms":"1G","xmx":"1G"},"constructor":{"xms":"4G","xmx":"4G"},"admin-console":{"xms":"4G","xmx":"4G"}}'"



sudo rm -rf /tmp/ECE.sh

