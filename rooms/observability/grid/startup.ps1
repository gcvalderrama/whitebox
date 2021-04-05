$sut_namespace = 'trial'
$sut_case = "/target/app/OnceUser.py"
$sut_verb = "POST"
# $sut_host = "https://mi.scotiabank.com.pe/digital-api/login/logout"
$sut_host = "http://192.168.18.16:8080/Traffic"
$sut_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.152 Safari/537.36"
$debug = $false


kubectl cluster-info
kubectl get nodes --show-labels
Start-Sleep(2)
kubectl top nodes
Start-Sleep(2)
kubectl delete namespace $sut_namespace --ignore-not-found

Start-Sleep(1)

kubectl create namespace $sut_namespace

write-host 'Start test'


kubectl create configmap -n ${sut_namespace} test-node-config `
--from-literal="PYTHONPATH=/target" `
--from-literal="LOCUST_LOCUSTFILE=${sut_case}" `
--from-literal="USER_AGENT=${sut_agent}" `
--from-literal="VERB=${sut_verb}" `
--from-literal="LOCUST_HOST=${sut_host}" `
--from-literal="LOCUST_MASTER_NODE_HOST=service-grid-master" `
--from-literal="LOCUST_MODE_WORKER=true" `
--from-literal="LOCUST_CSV=report" `
--from-literal="LOCUST_ONLY_SUMMARY=true" `
--from-literal="LOCUST_LOGFILE=/reports/locust.log" `
--from-literal="LOCUST_SPAWN_RATE=10" `
--from-literal="LOCUST_USERS=50" 

kubectl create configmap -n ${sut_namespace} test-master-config `
--from-literal="PYTHONPATH=/target" `
--from-literal="LOCUST_LOCUSTFILE=${sut_case}" `
--from-literal="USER_AGENT=${sut_agent}" `
--from-literal="VERB=${sut_verb}" `
--from-literal="LOCUST_HOST=${sut_host}" `
--from-literal="LOCUST_MODE_MASTER=true" `
--from-literal="LOCUST_EXPECT_WORKERS=3" `
--from-literal="LOCUST_CSV=report" `
--from-literal="LOCUST_ONLY_SUMMARY=true" `
--from-literal="LOCUST_LOGFILE=/reports/locust.log" `
--from-literal="LOCUST_SPAWN_RATE=10" `
--from-literal="LOCUST_USERS=50" 


kubectl apply -n ${sut_namespace} -f ./deployment.yaml

$pods = kubectl get pods -n $sut_namespace -o json | ConvertFrom-Json

Start-Sleep 2

$working = $true
while($working -eq $true)
{
    $working = $false
    foreach ($pod in $pods.items) {       
        $pod_name = $pod.metadata.name
        $working = kubectl get pod ${pod_name} -n ${sut_namespace} -o jsonpath='{.status.phase}'            
        if ($working -ne "Running"){
            $working = $true            
            write-host "wait seconds to start container ${pod_name}"            
        }
    }
    Start-Sleep 2
    
}

kubectl get pods -n ${sut_namespace} 

kubectl port-forward pod-master-test 8090:8089 -n ${sut_namespace}
  
#kubectl port-forward pod-grid-node  8090:8089 -n ${sut_namespace}

#Start-Sleep 2

#kubectl delete namespace -n ${sut_namespace}


