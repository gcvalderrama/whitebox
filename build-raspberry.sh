pushd raspberry

podman build -t whitebox-rb:latest .

podman tag whitebox-rb:latest f4phantom.skylab:5000/whitebox-rb:latest

podman push f4phantom.skylab:5000/whitebox-rb:latest --tls-verify=false

popd