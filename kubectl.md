```sh
kubectl version
kubectl cluster info
kubectl config view
```

### Context
```sh
kubectl config get-contexts
kubectl config unset <config_name>.<entity_name>
kubectl config use-context <context_name>
```

## General
```sh
kubectl get pods
kubectl get all
kubectl get nodes
kubectl get namespace
```

# Resources
```sh
kubectl get all -n <namespace>
```

## Service
```sh
kubectl get services -o wide
kubectl apply -f <service_file>
kubectl edit -f <service_file>
kubectl delete <service_name>
kubectl port-forward service/<service_name> <host_port>:<pod_port>
```

## Deployment
```sh
kubectl apply -f <deployment_file>
kubectl edit -f <deployment_file>
kubectl get deployments --show-labels
kubectl get deployments -l app=<label_name>
kubectl describe deployment <deployment_name>
kubectl delete deployment <deployment_name>
kubectl scale deployment <deployment_name> --replicas=<number_of_replicas> (kubectl scale deployment $(kubectl get deployment | grep <search_pattern> | awk '{print $1}') --replicas=<number_of_replicas>)
kubectl port-forward deployment/<deployment_name> <host_port>:<pod_port>
```

## Pod
```sh
kubectl apply -f <pod_file>
kubectl edit -f <pod_file>
kubectl get pods -n <ns> -o wide
kubectl describe pod <pod_id>
kubectl delete pod <pod_id>
kubectl port-forward pod/<pod_id> <host_port>:<pod_port>
```

## Shell
```sh
kubectl -n <ns> exec -it <pod_id> <shell_type>
```

## PV
```sh
kubectl get pv
```

# Monitoring
```sh
kubectl get events
kubectl logs -f <pod_id>
kubectl top pods --sort-by=memory
kubectl top nodes
```

# AZ Connect
```sh
az account set --subscription <subscription_id>
az aks get-credentials --resource-group <resource_group_name> --name <aks_name>
```