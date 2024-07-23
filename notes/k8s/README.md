# K8s

## Pods
- Pods of same container could be spread to mulptile nodes in the cluster, service ClusterIP (internal unique IP in the cluster) will load balance between them, Istio gateway would route incomming traffic to the appropriate service through its mappings