# Docker Setup

```

```

# Linux machine setup

### Ensure that Java is installed on the system else install Java via OpenJDK based on your Linux Distro

### Download the desired Kafka version from the official website
```
wget https://downloads.apache.org/kafka/3.5.1/kafka_2.13-3.5.1.tgz
```

### Extract the archive file and move it to the specified folder
```
tar -xvzf kafka_2.13-3.5.1.tgz
```

```
mv kafka_2.13-3.5.1 /usr/local/kafka
```

### Create background services to keep Kafka and Zookeeper running

#### Zookeeper
```
sudo vi /etc/systemd/system/zookeeper.service
```
```
[Unit]
Description=Apache Zookeeper server
Documentation=http://zookeeper.apache.org
Requires=network.target remote-fs.target
After=network.target remote-fs.target

[Service]
Type=simple
ExecStart=/usr/bin/bash /usr/local/kafka/bin/zookeeper-server-start.sh /usr/local/kafka/config/zookeeper.properties
ExecStop=/usr/bin/bash /usr/local/kafka/bin/zookeeper-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target
```

#### Kafka
```
sudo vi /etc/systemd/system/kafka.service
```
```
[Unit]
Description=Apache Kafka Server
Documentation=http://kafka.apache.org/documentation.html
Requires=zookeeper.service

[Service]
Type=simple
Environment="JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk"
ExecStart=/usr/bin/bash /usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties
ExecStop=/usr/bin/bash /usr/local/kafka/bin/kafka-server-stop.sh

[Install]
WantedBy=multi-user.target
```
> Just ensure that the Environment="JAVA_HOME=" property above points to the exact home directory of the Java installation

### Configuration

Navigate to config folder
```
cd /usr/local/kafka/config/
```

#### Zookeeper
> Focus only on the below properties and keep others as is
```
vi zookeeper.properties
```
```
# Choose whichever dir you want to store data in case there is a specific folder
dataDir=/tmp/zookeeper
clientPort=2181
maxClientCnxns=0
admin.enableServer=false
```

#### Kafka
> Focus only on the below properties and keep others as is
```
vi server.properties
```
```
broker.id=0
listeners=PLAINTEXT://ip_address:9092
advertised.listeners=PLAINTEXT://ip_address:9092
log.dirs=/tmp/kafka-logs
```
> The ip_address needs to be replaced using the ip address of the server. You can obtain it using the following command
```
curl ifconfig.me
```

### Enabling the services

#### Reload the systemmd daemon
```
sudo systemctl daemon-reload
```

#### Start the services
```
sudo systemctl start zookeeper
sudo systemctl start kafka
```

#### Enable the services so that they auto-start on system restart
```
sudo systemctl enable zookeeper
sudo systemctl enable kafka
```

#### Command to restart any service
```
sudo systemctl restart zookeeper
sudo systemctl restart kafka
```

#### Test using this command
```
sudo systemctl status zookeeper kafka
```

