$sut_namespace = 'trial'
$sut_case = "/target/app/OnceUser.py"
$sut_host = "https:www.google.com"
$sut_users = "2"
$sut_rate = "2"
$sut_run_time = "1m"
$sut_run_seconds = "60"
$sut_verb = "GET"


Remove-Item -LiteralPath "./results/" -Force -Recurse
New-Item -ItemType directory -Path "./results"


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

$template = Get-Content "./../../worker/deployment.yaml"
$template = $template   -replace "__case__","${sut_case}" `
                        -replace "__host__","${sut_host}" `
                        -replace "__users__","${sut_users}" `
                        -replace "__rate__","${sut_rate}" `
                        -replace "__run_time__","${sut_run_time}" `
                        -replace "__verb__","${sut_verb}"


$template | Out-File -FilePath ./results/template.yaml

kubectl apply -f ./results/template.yaml -n ${sut_namespace}

Start-Sleep $sut_run_seconds

kubectl cp "${sut_namespace}/pod-test:/target/app/report_failures.csv" "./results"
kubectl cp "${sut_namespace}/pod-test:/target/app/report_stats.csv" "./results"
kubectl cp "${sut_namespace}/pod-test:/target/app/report_stats_history.csv" "./results"


Start-Sleep 2

kubectl delete namespace $sut_namespace
kubectl delete namespace trial-single
