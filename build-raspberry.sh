sudo docker build -t whitebox-rb:latest -f DockerfileRaspberry .

sudo docker tag whitebox-rb:latest f4phantom.skylab:5000/whitebox-rb:latest

sudo docker push f4phantom.skylab:5000/whitebox-rb:latest  --tls-verify=false

