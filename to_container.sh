#!/bin/bash

# https://medium.com/@gchudnov/copying-data-between-docker-containers-26890935da3f
docker exec -i docker_backend_1 sh -c 'cat > /root/dump-product.pl' < ./dump-product.pl
