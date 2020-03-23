echo "DESTROYING :::>>> Cluster ::: [[[ kube-land ]]]..."

pkill -f k8dash | true

pkill -f 8761 | true

pkill -f 8000 | true

pkill -f 2181 | true

pkill -f 9000 | true

pkill -f 9092 | true

kind delete cluster --name kube-land

sleep 20

docker stop zoobab/kind:latest

sleep 20

echo "DESTROYED :::>>> Cluster ::: [[[ kube-land ]]]..."