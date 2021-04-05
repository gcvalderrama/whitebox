# sudo docker run -it --rm --entrypoint /bin/sh whitebox



sudo docker run -it --rm \
 -e "LOCUST_LOCUSTFILE=/target/app/OnceUser.py" \
 -e "LOCUST_HOST=http://192.168.18.16:8080/Traffic" \
 -e "LOCUST_USERS=2" \
 -e "LOCUST_HATCH_RATE=5" \
 -e "VERB=POST" \
 -e "USER_AGENT=Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.152 Safari/537.36" \
 -p 8092:8089 whitebox 

exit 0

sudo docker run -d --rm  -p 21:21 -p 21000-21010:21000-21010 -e USERS="trial|1234|/home/tests" delfer/alpine-ftp-server


sudo docker run -it --rm -e "LOCUST_LOCUSTFILE=/target/app/OnceUser.py" \
 -e "LOCUST_HOST=http://localhost:80" \
 -e "LOCUST_USERS=2" \
 -e "LOCUST_HATCH_RATE=2" \
 -e "LOCUST_CSV=report" \
 -e "LOCUST_RUN_TIME=5m" \
 -e "LOCUST_LOGFILE=/reports/locust.log" \
 -e "LOCUST_HEADLESS=true" \
 -e "LOCUST_EXIT_CODE_ON_ERROR=0" \
 -p 8089:8089 whitebox 

exit 0

sudo docker run -it --rm -p 8089:8089 whitebox 

sudo docker run -it --rm -e "LOCUST_LOCUSTFILE=/target/app/OnceUser.py" \
 -e "LOCUST_HOST=https://google.com" \
 -e "LOCUST_USERS=10" \
 -e "LOCUST_HATCH_RATE=2" \
 -e "LOCUST_CSV=report" \
 -e "TARGET=/demo?aa=a" \
 -e "LOCUST_LOGFILE=/reports/locust.log" \
 -p 8089:8089 whitebox 