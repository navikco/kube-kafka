#!/bin/bash

set -e

if [ $# -eq 1 ]
then

    ENVIRONMENT=${1}
    echo "ENVIRONMENT :::>>> ${ENVIRONMENT}"

else
    echo "Usage: . ./setupKubeKafka.sh <<ENVIRONMENT>>"
    exit 1
fi

# Create KAFKA Ecosystem
# ----------------------

KAFKA_SCRIPTS_HOME=${PWD}
KAFKA_CLUSTERS_HOME=../cluster/kube-${ENVIRONMENT}/

echo "KAFKA_CLUSTERS_HOME ::: ${KAFKA_CLUSTERS_HOME}"
ls -R ${KAFKA_CLUSTERS_HOME}/

./destroyKubeKafka.sh ${ENVIRONMENT}

cd ${KAFKA_CLUSTERS_HOME}/

echo "CREATING Namespace :::>>> [[[ kube-${ENVIRONMENT} ]]]..."

kubectl create -f kube-${ENVIRONMENT}.yml

echo "CREATED Namespace :::>>> [[[ kube-${ENVIRONMENT} ]]]..."

kubectl get namespaces


echo "CREATING KUBE Zookeeper Service :::>>> [[[ kube-${ENVIRONMENT}-zookeeper-service ]]]..."

kubectl create -f kube-${ENVIRONMENT}-zookeeper-service.yml

echo "CREATED KUBE Zookeeper Service :::>>> [[[ kube-${ENVIRONMENT}-zookeeper-service ]]]..."

kubectl get services --namespace=kube-${ENVIRONMENT}


echo "CREATING KUBE Zookeeper Instance :::>>> [[[ kube-${ENVIRONMENT}-zookeeper ]]]..."

kubectl create -f kube-${ENVIRONMENT}-zookeeper.yml
sleep 30

echo "CREATED KUBE Zookeeper Instance :::>>> [[[ kube-${ENVIRONMENT}-zookeeper ]]]..."

kubectl get pods --namespace=kube-${ENVIRONMENT}


echo "CREATING KUBE Kafka Service :::>>> [[[ kube-${ENVIRONMENT}-kafka-service ]]]..."

kubectl create -f kube-${ENVIRONMENT}-kafka-service.yml

echo "CREATED KUBE Kafka Service :::>>> [[[ kube-${ENVIRONMENT}-kafka-service ]]]..."

kubectl get services --namespace=kube-${ENVIRONMENT}


echo "CREATING KUBE Kafka Instance :::>>> [[[ kube-${ENVIRONMENT}-kafka ]]]..."

kubectl create -f kube-${ENVIRONMENT}-kafka.yml
sleep 30

echo "CREATED KUBE Kafka Instance :::>>> [[[ kube-${ENVIRONMENT}-kafka ]]]..."

kubectl get pods --namespace=kube-${ENVIRONMENT}


echo "CREATING KUBE Kafka Manager Service :::>>> [[[ kube-${ENVIRONMENT}-kafka-manager-service ]]]..."

kubectl create -f kube-${ENVIRONMENT}-kafka-manager-service.yml

echo "CREATED KUBE Kafka Manager Service :::>>> [[[ kube-${ENVIRONMENT}-kafka-manager-service ]]]..."

kubectl get services --namespace=kube-${ENVIRONMENT}


echo "CREATING KUBE Kafka Manager Instance :::>>> [[[ kube-${ENVIRONMENT}-kafka-manager ]]]..."

kubectl create -f kube-${ENVIRONMENT}-kafka-manager.yml

echo "CREATED KUBE Kafka Manager Instance :::>>> [[[ kube-${ENVIRONMENT}-kafka-manager ]]]..."

exit 0
