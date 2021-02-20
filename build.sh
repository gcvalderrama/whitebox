sudo podman build -t whitebox:latest --no-cache -f Dockerfile . 

sudo podman tag whitebox:latest f4phantom.skylab:5000/whitebox:latest

sudo podman push f4phantom.skylab:5000/whitebox:latest --tls-verify=false

