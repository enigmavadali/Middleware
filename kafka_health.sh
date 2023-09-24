#!/bin/bash

echo "Running Kafka health check script..."
# Check if the Kafka broker is healthy by attempting to list topics
/opt/kafka_2.13-2.8.1/bin/kafka-broker-api-versions.sh --bootstrap-server localhost:9092 >/dev/null 2>&1

# Exit with 0 if the Kafka broker is healthy, otherwise exit with a non-zero code
if [ $? -eq 0 ]; then
  exit 0
else
  exit 1
fi