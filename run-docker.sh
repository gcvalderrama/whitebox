# sudo docker run -it --rm --entrypoint /bin/sh whitebox


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
