#!/bin/bash

set -e

if [ $# -eq 1 ]
then

    ENVIRONMENT=${1}
    echo "ENVIRONMENT :::>>> ${ENVIRONMENT}"

else
    echo "Usage: . ./kubeLandBlast.sh <<ENVIRONMENT>>"
    exit 1
fi

KAFKA_SCRIPTS_HOME=${PWD}
KAFKA_CLUSTERS_HOME=${KAFKA_SCRIPTS_HOME}/../cluster/kube-${ENVIRONMENT}/

echo "KAFKA_CLUSTERS_HOME ::: ${KAFKA_CLUSTERS_HOME}"
ls -alR ${KAFKA_CLUSTERS_HOME}/

./destroyKubeLandCluster.sh

./setupKubeLandCluster.sh

./setupKubeLandK8Dash.sh

echo "CREATING :::>>> Namespace ::: [[[ ${ENVIRONMENT} ]]]..."

K8S_MASTER_IP=$(echo $(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' | awk '{print $1;}'))
echo "Kube Master IP >>> $K8S_MASTER_IP"

echo "CREATING :::>>> KUBE Services in ::: [[[ ${ENVIRONMENT} ]]]..."

./setupKubeKafka.sh ${ENVIRONMENT}

sleep 120

echo "CREATED :::>>> KUBE Services in ::: [[[ ${ENVIRONMENT} ]]]..."

echo "FORWARDING :::>>> PORTS in ::: [[[ ${ENVIRONMENT} ]]]..."

kubectl port-forward deployment/kube-green-zookeeper 2181:2181 --namespace=kube-${ENVIRONMENT} &
kubectl port-forward deployment/kube-green-kafka 9092:9092 --namespace=kube-${ENVIRONMENT} &
kubectl port-forward deployment/kube-green-kafka-manager 9000:9000 --namespace=kube-${ENVIRONMENT} &
kubectl port-forward deployment/k8dash 8000:4654 --namespace=kube-system &

echo "FORWARDED :::>>> PORTS in ::: [[[ ${ENVIRONMENT} ]]]..."

echo "GENERATING :::>>> Access Key For ::: [[[ K8Dash ]]]..."

./fetchKubeLandK8DashAccessKey.sh

echo "GENERATED :::>>> Access Key For ::: [[[ K8Dash ]]]..."

exit 0
