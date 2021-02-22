# https://github.com/delfer/docker-alpine-ftp-server


sudo docker run -d --rm  -p 21:21 -p 21000-21010:21000-21010 -e USERS="trial|1234|/home/tests" delfer/alpine-ftp-server

apt install ncftp

ncftpput -u trial -p 1234 192.168.18.16 . README.md

ncftpput -u trial -p 1234 f4phantom.skylab . containerd.toml

ncftpput -u trial -p 1234 192.168.18.16 -m demo README.md


kubectl apply -f deployment.yaml -n trial
kubectl describe pod pod-ftp  -n trial

kubectl logs pod-ftp -n trial
kubectl delete -f deployment.yaml --grace-period=0 --force
kubectl describe pod  pod-ftp -n trial
kubectl delete pod pod-ftp -n trial --grace-period=0 --force


-rw-r--r-- 1 locust locust   31 2021-02-21 22:34:25.742468211 +0000 report_failures.csv
-rw-r--r-- 1 locust locust  555 2021-02-21 22:34:25.742468211 +0000 report_stats.csv
-rw-r--r-- 1 locust locust 6552 2021-02-21 22:34:25.742468211 +0000 report_stats_history.csv



