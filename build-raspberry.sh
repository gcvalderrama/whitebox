pushd raspberry

sudo docker build -t whitebox-rb:latest .

sudo docker podman tag whitebox-rb:latest f4phantom.skylab:5000/whitebox-rb:latest

sudo docker push f4phantom.skylab:5000/whitebox-rb:latest 

popd