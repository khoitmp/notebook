# K8s

## Commands
|            | Command                                                                  | Params                          | Description                                                                                                                     |
| ---------- | ------------------------------------------------------------------------ | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| Config     |                                                                          |                                 |                                                                                                                                 |
|            | export KUBECONFIG=/path/kubeconfig.yaml                                  |                                 |                                                                                                                                 |
| Params     |                                                                          |                                 |                                                                                                                                 |
|            | --show-labels                                                            |                                 | Get recoures with their labels                                                                                                  |
|            | -o wide                                                                  |                                 | Get resources with their IPs                                                                                                    |
|            | -n <namespace>                                                           |                                 | Get resources within specified namespace                                                                                        |
|            | -l <key>=<value>                                                         |                                 | Get resources with specified label                                                                                              |
| Settings   |                                                                          |                                 |                                                                                                                                 |
|            | kubectl version                                                          |                                 |                                                                                                                                 |
|            | kubectl cluster info                                                     |                                 |                                                                                                                                 |
|            | kubectl config view                                                      |                                 |                                                                                                                                 |
|            | kubectl config get-contexts                                              |                                 |                                                                                                                                 |
|            | kubectl config use-context <context_name>                                |                                 |                                                                                                                                 |
| Resources  |                                                                          |                                 |                                                                                                                                 |
|            | kubectl get all                                                          |                                 |                                                                                                                                 |
| Namespace  |                                                                          |                                 |                                                                                                                                 |
|            | kubectl get namespace                                                    |                                 |                                                                                                                                 |
|            | kubectl create namespace <namespace>                                     |                                 |                                                                                                                                 |
| Nodes      |                                                                          |                                 |                                                                                                                                 |
|            | kubectl get nodes                                                        |                                 |                                                                                                                                 |
|            | kubectl label nodes <node_name> <key>=<value>                            |                                 | Create label                                                                                                                    |
|            | kubectl label nodes <node_name> <key>-                                   |                                 | Remove label                                                                                                                    |
| Pods       |                                                                          |                                 |                                                                                                                                 |
|            | kubectl get pods                                                         |                                 |                                                                                                                                 |
|            | kubectl describe pod <pod_id>                                            |                                 |                                                                                                                                 |
|            | kubectl delete pod <pod_id>                                              |                                 |                                                                                                                                 |
|            | kubectl port-forward pod/<pod_id> <host_port>:<pod_port>                 |                                 |                                                                                                                                 |
|            | kubectl exec                                                             | -it <pod_id> <shell_type>       | Shell a pod                                                                                                                     |
| Services   |                                                                          |                                 |                                                                                                                                 |
|            | kubectl get services                                                     |                                 |                                                                                                                                 |
|            | kubectl delete <service_name>                                            |                                 |                                                                                                                                 |
|            | kubectl port-forward service/<service_name> <host_port>:<pod_port>       |                                 |                                                                                                                                 |
| Deployment |                                                                          |                                 |                                                                                                                                 |
|            | kubectl get deployments                                                  |                                 |                                                                                                                                 |
|            | kubectl apply                                                            | -f <deployment_file>.yml        |                                                                                                                                 |
|            | kubectl edit                                                             | -f <deployment_file>.yml        |                                                                                                                                 |
|            | kubectl describe deployment <deployment_name>                            |                                 |                                                                                                                                 |
|            | kubectl delete deployment <deployment_name>                              |                                 |                                                                                                                                 |
|            | kubectl scale deployment <deployment_name>                               | --replicas=<number_of_replicas> | kubectl scale deployment $(kubectl get deployment \| grep <search_pattern> \| awk '{print $1}') --replicas=<number_of_replicas> |
|            | kubectl port-forward deployment/<deployment_name> <host_port>:<pod_port> |                                 |                                                                                                                                 |
| Ingress    |                                                                          |                                 |                                                                                                                                 |
|            | kubectl get ingress                                                      |                                 |                                                                                                                                 |
|            | kubectl describe ingress <ingress_name>                                  |                                 |                                                                                                                                 |
| PV         |                                                                          |                                 |                                                                                                                                 |
|            | kubectl get pv                                                           |                                 |                                                                                                                                 |
|            | kubectl get pvc                                                          |                                 |                                                                                                                                 |
| Jobs       | kubectl get jobs                                                         |                                 |                                                                                                                                 |
|            | kubectl get cronjobs                                                     |                                 |                                                                                                                                 |
| Monitoring |                                                                          |                                 |                                                                                                                                 |
|            | kubectl get events                                                       |                                 |                                                                                                                                 |
|            | kubectl logs                                                             | -f <pod_id>                     |                                                                                                                                 |
|            | kubectl top pods                                                         | --sort-by=memory                |                                                                                                                                 |
|            | kubectl top nodes                                                        |                                 |                                                                                                                                 |
|            |                                                                          |                                 |                                                                                                                                 |

## NGINX Controller
- `Ingress Controller`:
  - A separate DaemonSet (a controller which runs on all nodes, including any future ones) along with a Service that can be used to utilize routing and proxying. It's based for example on NGINX which acts as the old-school reverse proxy receiving incoming traffic and forwarding it to HTTP(S) routes defined in the Ingress resources in point 2 below (distinguished by their different routes/URLs)
- `Ingress Rules`:
  - Separate Kubernetes resources with kind: Ingress. Will only take effect if Ingress Controller is already deployed on that node
  - While Ingress Controller can be deployed in any namespace it is usually deployed in a namespace separate from your app services (e.g. ingress or kube-system). It can see Ingress rules in all other namespaces and pick them up. However, each of the Ingress rules must reside in the namespace where the app that they configure reside

### Controller
```sh
# Deploy the controller
curl -O https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

# Check the controller installed
kubectl get deployments -n <ns>
kubectl get services -n <ns>
kubectl get pods -n <ns>
```

### Resources
```sh
# Check the resources installed
kubectl get ingress -n <ns>
```

## Cert Manager
```sh
kubectl apply -f clusterissuer.yaml              
kubectl apply -f certificate.yaml

# Check the certs installed
kubectl describe certificate tls-cert -n default
kubectl logs -l app=cert-manager -n cert-manager
```