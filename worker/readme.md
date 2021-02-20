kubectl delete -f deployment.yaml
kubectl apply -f deployment.yaml
kubectl get pods -n trial -o wide 
kubectl describe pod pod-coldstart -n trial
kubectl logs pod-coldstart -n trial performance

                                
kubectl taint nodes $(hostname) node.kubernetes.io/disk-pressure:NoSchedule-

podman pull f4phantom.skylab:5000/whitebox:latest --tls-verify=false
podman run -it --entrypoint /bin/bash  f4phantom.skylab:5000/whitebox:latest

kubectl exec -it pod-coldstart -n trial -- /bin/bash 

kubectl exec -it pod-coldstart -n trial -c performance -- /bin/bash 