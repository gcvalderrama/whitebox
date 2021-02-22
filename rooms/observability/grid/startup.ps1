$sut_namespace = 'trial-single'
$sut_case = "/target/app/OnceUser.py"
$sut_verb = "GET"
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

$template = Get-Content "./deployment.yaml"
$template = $template   -replace "__case__","${sut_case}" `
                        -replace "__agent__","${sut_agent}" `
                        -replace "__verb__","${sut_verb}"

if($debug){ 
    $template | Out-File -FilePath ./instance.yaml    
}

$template | kubectl apply -n ${sut_namespace} -f - 

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


