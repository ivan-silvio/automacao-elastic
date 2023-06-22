
runuser -l elastic -c "bash <(curl -fsSL https://download.elastic.co/cloud/elastic-cloud-enterprise.sh) install --force --availability-zone POC-01 --memory-settings '{"runner":{"xms":"4G","xmx":"4G"},"allocator":{"xms":"4G","xmx":"4G"},"zookeeper":{"xms":"4G","xmx":"4G"},"director":{"xms":"4G","xmx":"4G"},"constructor":{"xms":"4G","xmx":"4G"},"admin-console":{"xms":"4G","xmx":"4G"}}'"

#docker rm -f frc-runners-runner frc-allocators-allocator $(docker ps -a -q); sudo rm -rf /mnt/data/elastic/ && docker ps -a



sudo rm -rf /tmp/ECE.sh
