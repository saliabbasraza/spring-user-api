# Deployment on Google Cloud

* Cloud Shell\
``export PROJECT_ID=$(gcloud config get-value project -q)``

### Docker Commands

* Datareader \
    ``git clone https://saliabbasraza:<password>@github.com/saliabbasraza/spring-datareader.git``\
    ``cd spring-datareader/``\
    ``./mvnw clean package``\
    ``docker build -t gcr.io/${PROJECT_ID}/spring-datareader .``\
    ``docker push gcr.io/brave-pen-272418/spring-datareader``

* UserApi \
    ``git clone https://saliabbasraza:<password>@github.com/saliabbasraza/spring-user-api.git``\
    ``cd spring-user-api/``\
    ``./mvnw clean package``\
    ``docker build -t gcr.io/${PROJECT_ID}/spring-user-api .``\
    ``docker push gcr.io/brave-pen-272418/spring-user-api``
    
### Kubernetes Commands

   ``gcloud container clusters create k8s-medium --num-nodes=3 --zone=us-central1-b``\
   ``kubectl run dataserver --image=gcr.io/${PROJECT_ID}/spring-datareader:latest --port 8080 --labels="app=spring-datareader,tier=backend"``\
   ``kubectl run userapi --image=gcr.io/${PROJECT_ID}/spring-user-api:latest --port 8080 --labels="app=spring-user-api,tier=frontend"``\
   ``kubectl expose deployment userapi --type=LoadBalancer --port 80 --target-port 8080``\
   ``kubectl expose deployment dataserver --type=ClusterIP --port 80 --target-port 8080 --selector="app=spring-datareader,tier=backend"``
### Redeploy
    kubectl rollout restart deployment userapi
    kubectl rollout restart deployment dataserver   
### Debug Commands
    kubectl get pod
    kubectl exec -it <pod-name> -- /bin/bash
