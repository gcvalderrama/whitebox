$sut_namespace = 'trial-single'
$sut_case = "/target/app/OnceUser.py"
$sut_verb = "GET"
$sut_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.152 Safari/537.36"

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
                        
$template | Out-File -FilePath ./instance.yaml

kubectl apply -f ./instance.yaml -n ${sut_namespace}

$working = $true
while($working -eq $true)
{   
    $working = kubectl get pod pod-single-test -n ${sut_namespace} -o jsonpath='{.status.containerStatuses[0].ready}'        
    write-host "wait seconds to start container"
    Start-Sleep 2
}

kubectl port-forward pod-single-test  8090:8089 -n ${sut_namespace}

Start-Sleep 2

kubectl delete namespace -n ${sut_namespace}


