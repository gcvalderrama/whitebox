pushd raspberry

podman build -t whitebox:latest .

podman tag whitebox:latest f4phantom.skylab:5000/whitebox:latest

podman push f4phantom.skylab:5000/whitebox:latest --tls-verify=false

popd