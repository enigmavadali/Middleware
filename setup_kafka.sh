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

/opt/kafka_2.13-2.8.1/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic $TEST_TOPIC_NAME
echo "topic $TEST_TOPIC_NAME was created"

# for message in "cat sample_messages.txt"; do
#     echo "$message" | /opt/kafka_2.13-2.8.1/bin/kafka-console-producer.sh --topic $TEST_TOPIC_NAME --bootstrap-server localhost:9092
# done