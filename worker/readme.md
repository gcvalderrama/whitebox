kubectl delete -f deployment.yaml
kubectl apply -f deployment.yaml
kubectl get pods -n trial -o wide 
kubectl describe pod pod-coldstart -n trial
    kubectl logs pod-coldstart -n trial performance

kubectl logs pod-coldstart -n trial 

kubectl exec -it pod-coldstart -n trial -- /bin/bash 
kubectl exec -it pod-coldstart -n trial -c performance -- /bin/bash 