
rm -R app/*.csv

sudo docker build -t whitebox:latest --no-cache -f Dockerfile . 
sudo docker build -t whitebox-headless:latest --no-cache -f DockerfileHeadless . 

sudo docker tag whitebox:latest f4phantom.skylab:5000/whitebox:latest
sudo docker tag whitebox-headless:latest f4phantom.skylab:5000/whitebox-headless:latest

sudo docker push f4phantom.skylab:5000/whitebox:latest 
sudo docker push f4phantom.skylab:5000/whitebox-headless:latest 

