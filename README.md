# Kube Kind Demos

_**Run Kubernetes Cluster Locally**_
--


- Install Kind on your Local Machine (Mac or Windows Instructions below)

    https://kind.sigs.k8s.io/docs/user/quick-start


- Install Chocolatey & Kind on your Local Machine (Only For Windows)

    Open Command Shell with Administration Rights
    
    `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`

    `choco install kind`


- Verify that Kind is properly installed by running the commands below,
 
    `kind get clusters`
    
    `kind get nodes`


_**Start Docker Desktop Locally**_
--

- Make sure your Local Docker Desktop is Up and Running beforehand



_**Setup Kube Kind Cluster and Namespace**_
--


`cd kube-kafka/setup/scripts/`

`chmod 700 *.sh`

`./kubeLandBlast.sh green`


- This would start Docker Containers for Kubernetes Kind (https://github.com/kubernetes-sigs/kind)

- It would also start the Kubernetes Pod for K8Dash UI Dashboard

- It would also start --
        
        - Confluent Zookeeper
        
        - Confluent Kafka
        
        - Yahoo Kafka-Manager

- It would also print the **LONG Security Token** on the Console for K8Dash UI Login


- Once the Command exits with success,
     
    - You can Browse your K8Dash UI on --> 
    
        - Copy the **LONG Security Token** displayed on the Console by the last command and use it to Login on K8Dash UI 
    
            http://localhost:8000/

        - If Your K8Dash UI is not up on Windows, you can run the PORT FORWARD command below and retry,
        
            `kubectl port-forward deployment/k8dash 8000:4654 --namespace=kube-system &`

        - If You Lost **LONG Security Token** to login to your K8Dash UI, you can get it again by executing the script below,
        
            `./fetchKubeLandK8DashAccessKey.sh`

    - Now, You should be able to execute any **kubectl** Commands

    - To Check your Local Kubernetes Cluster,
    
        `kubectl get nodes`
    
        `kubectl get namespaces`
        
        `kubectl get deployments --namespace=kube-green`
                
        `kubectl get pods --namespace=kube-green`

        `kubectl get services --namespace=kube-green`
        

- To Test Kafka Ecosystem Manually,

    - Publish and Consume the Messages on Kafka 
    
    - Run the **Shell Scripts** below with **TOPIC NAME** on TWO separate Command Shells,

        `./kubeKafkaProducer.sh kube_test`
    
        `./kubeKafkaConsumer.sh kube_test`

    - Now Both Test Kafka Producer and Consumer are waiting on the Shells
     
    - Type Test Messages on Kafka Producer Shell and "Enter"
    
    - This should immediately **Publish** a Message to Kafka Topic you mentioned
     
    - If you turn over to the other Shell where Kafka Consumer is Running - You would see the Message Consumed and Displayed on the Console     



_**Cleanup LOCAL Workspace once Done**_
---

`cd kube-kafka/setup/scripts/`

`./destroyKubeLandCluster.sh`



_**Kube-Land Utility Scripts/Tools**_
---
| Tool/Script   | Argument(s) | Cluster	| K8Dash UI  | Namespace | Kafka/Zookeeper/KafkaManager | Purpose |
| ------------- |:-------------:| -----:|-----:|-----:|-----:|-----:|
| **kubeLandBlast.sh** | Environment (i.e. blue/green) | Yes | Yes | Yes | Yes | Run Kind Docker Container and Setup New Kind Cluster with Namespace, K8Dash UI, Admin Service & Entire Kafka Ecosystem|
| **destroyKubeLandCluster.sh** | | Yes | Yes | Yes | Yes | Destroy Kind Cluster including Namespace, K8Dash UI, Admin Service & Entire Kafka Ecosystem|
| **destroyKubeKafka.sh** | | | | Yes | Yes | Destroy Namespace & Entire Kafka Ecosystem|
| **setupKubeLandK8Dash.sh** | | | Yes | | | Delete and Recreate K8Dash UI |
| **fetchKubeLandK8DashAccessKey.sh** | | | | | | Display Secret Token to Logon to K8Dash UI|
| **kubeKafkaPublisher.sh** | TOPIC NAME | | | | | Start Kafka Publisher for Testing|
| **kubeKafkaConsumer.sh** | TOPIC NAME | | | | | Start Kafka Consumer for Testing|