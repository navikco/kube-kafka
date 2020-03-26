#!/bin/bash

set -e

if [ $# -eq 1 ]
then

    ENVIRONMENT=${1}
    echo "ENVIRONMENT :::>>> ${ENVIRONMENT}"

else
    echo "Usage: ./destroyKubeKafka.sh <<ENVIRONMENT>>"
    exit 1
fi

# Destroy KAFKA Ecosystem
# ----------------------------

KAFKA_SCRIPTS_HOME=${PWD}
KAFKA_CLUSTERS_HOME=../cluster/kube-${ENVIRONMENT}/

echo "KAFKA_CLUSTERS_HOME ::: ${KAFKA_CLUSTERS_HOME}"
ls -R ${KAFKA_CLUSTERS_HOME}/

cd ${KAFKA_CLUSTERS_HOME}/

echo "DESTROYING Namespace :::>>> [[[ kube-${ENVIRONMENT} ]]]..."

kubectl delete -f kube-${ENVIRONMENT}.yml | true

echo "DESTROYED Namespace :::>>> [[[ kube-${ENVIRONMENT} ]]]..."

exit 0
