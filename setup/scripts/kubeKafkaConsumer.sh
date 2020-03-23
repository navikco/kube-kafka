#!/bin/bash

set -e

if [ $# -eq 1 ]
then

    TOPIC=${1}
    echo "TOPIC :::>>> ${TOPIC}"

else
    echo "Usage: ./kubeKafkaConsumer.sh <<TOPIC>>"
    exit 1
fi

# Create Consumer for KAFKA Ecosystem
# -----------------------------------

kubectl exec -it $(echo $(kubectl get pods -o=jsonpath='{.items[0].metadata.name}' --namespace=kube-green)) --namespace=kube-green -c kube-green-kafka -- bash -c "/usr/bin/kafka-console-consumer --bootstrap-server localhost:9092 --topic ${TOPIC} --from-beginning"

exit 0
