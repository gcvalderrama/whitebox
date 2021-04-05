export USER_AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.149 Safari/537.36"
export VERB="POST"
export LOCUST_HOST="http://localhost:8080/Traffic"
locust -f app/OnceUser.py --users 2 -r 2 