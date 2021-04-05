$sut_namespace = 'trial'
$sut_case = "/target/app/RandomAgentUser.py"
$sut_verb = "GET"
$sut_host = "https://mi.scotiabank.com.pe/digital-api/login/logout"
$sut_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.152 Safari/537.36"
$debug = $false


kubectl cluster-info
kubectl get nodes --show-labels
Start-Sleep(2)
kubectl top nodes
Start-Sleep(2)
kubectl delete namespace $sut_namespace --ignore-not-found

Start-Sleep(1)

kubectl get namespaces

kubectl create namespace $sut_namespace

write-host 'Start test'

kubectl create configmap -n ${sut_namespace} test-config `
--from-literal="PYTHONPATH=/target" `
--from-literal="LOCUST_LOCUSTFILE=${sut_case}" `
--from-literal="USER_AGENT=${sut_agent}" `
--from-literal="VERB=${sut_verb}" `
--from-literal="LOCUST_HOST=${sut_host}" `
--from-literal="LOCUST_MODE_MASTER=false" `
--from-literal="LOCUST_CSV=report" `
--from-literal="LOCUST_LOGFILE=/reports/locust.log" `
--from-literal="LOCUST_SPAWN_RATE=10" `
--from-literal="LOCUST_USERS=50" `
--from-literal="LOCUST_HEADLESS=false" 

kubectl apply -n ${sut_namespace} -f ./deployment.yaml 

$working = "start"
while($working -ne "Running")
{   
    $working = kubectl get pod pod-single-test -n ${sut_namespace} -o jsonpath='{.status.phase}'        
    write-host "wait seconds to start container ${woking}"
    Start-Sleep 2
}

kubectl port-forward pod-single-test  8090:8089 -n ${sut_namespace}

Start-Sleep 2

kubectl delete namespace -n ${sut_namespace}


