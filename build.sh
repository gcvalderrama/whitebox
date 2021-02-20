sudo docker build -t whitebox:latest --no-cache -f Dockerfile . 

sudo docker tag whitebox:latest f4phantom.skylab:5000/whitebox:latest

sudo docker push f4phantom.skylab:5000/whitebox:latest 

