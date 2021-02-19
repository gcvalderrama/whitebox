pushd raspberry

sudo podman build -t whitebox-rb:latest .

sudo podman tag whitebox-rb:latest f4phantom.skylab:5000/whitebox-rb:latest

sudo podman push f4phantom.skylab:5000/whitebox-rb:latest  --tls-verify=false

popd