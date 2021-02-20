sudo docker build -t whitebox-rb:latest --no-cache -f DockerfileRaspberry .

sudo docker tag whitebox-rb:latest f4phantom.skylab:5000/whitebox-rb:latest

sudo docker push f4phantom.skylab:5000/whitebox-rb:latest  

