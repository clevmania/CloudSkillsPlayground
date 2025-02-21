# Deploy GKE clusters
export my_cluster=autopilot-cluster-1
gcloud container clusters create-auto $my_cluster --region $my_region

# Connect to a GKE cluster
gcloud container clusters get-credentials $my_cluster --region $my_region

# Use kubectl to inspect a GKE cluster
kubectl config view
kubectl cluster-info
kubectl config current-context
kubectl config get-contexts
kubectl config use-context gke_${DEVSHELL_PROJECT_ID}_Region_autopilot-cluster-1

# Deploy Pods to GKE clusters
kubectl create deployment --image nginx nginx-1

sleep 30

my_nginx_pod=$(kubectl get pods -o=jsonpath='{.items[0].metadata.name}')

kubectl top node

echo $my_nginx_pod
kubectl describe pod $my_nginx_pod

# Push a file into a container

cat > test.html <<EOF_END
<html> <header><title>This is title</title></header>
<body> Hello world </body>
</html>
EOF_END

kubectl cp ~/test.html $my_nginx_pod:/usr/share/nginx/html/test.html

# Expose the Pod for testing
kubectl expose pod $my_nginx_pod --port 80 --type LoadBalancer
kubectl get services

# Introspect GKE Pods
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
cd ~/ak8s/GKE_Shell/
kubectl apply -f ./new-nginx-pod.yaml

rm new-nginx-pod.yaml 

cat > new-nginx-pod.yaml <<EOF_END
apiVersion: v1
kind: Pod
metadata:
  name: new-nginx
  labels:
    name: new-nginx
spec:
  containers:
  - name: new-nginx
    image: nginx
    ports:
    - containerPort: 80
EOF_END

kubectl apply -f ./new-nginx-pod.yaml