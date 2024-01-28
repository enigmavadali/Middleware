#/bin/bash

# while ! nc -z kafka 9092; do
#   sleep 1
# done

# while true; do
#   /opt/kafka_2.13-2.8.1/bin/kafka-broker-api-versions.sh --bootstrap-server localhost:9092 >/dev/null 2>&1
#   if [ $? -eq 0 ]; then
#     echo "Kafka broker is now available and initialized."
#     break
#   fi
#   echo "Waiting for broker"
#   sleep 1
# done

echo "Kafka broker is now healthy. Running setup"

echo "Deleting Topics"

/opt/kafka_2.13-2.8.1/bin/kafka-topics.sh --zookeeper zookeeper:2181 --delete --topic $RESIDENT_TOPIC

/opt/kafka_2.13-2.8.1/bin/kafka-topics.sh --zookeeper zookeeper:2181 --delete --topic $SENSOR_TOPIC

echo "Creating Topics"

/opt/kafka_2.13-2.8.1/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic $RESIDENT_TOPIC
echo "topic $RESIDENT_TOPIC was created"

/opt/kafka_2.13-2.8.1/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic $SENSOR_TOPIC
echo "topic $SENSOR_TOPIC was created"

# for message in "cat sample_messages.txt"; do
#     echo "$message" | /opt/kafka_2.13-2.8.1/bin/kafka-console-producer.sh --topic $TEST_TOPIC_NAME --bootstrap-server localhost:9092
# done