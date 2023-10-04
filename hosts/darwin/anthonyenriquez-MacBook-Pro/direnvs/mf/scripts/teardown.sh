#!/usr/bin/env bash
service_name=$(docker ps -q | head -n 1 | xargs -I{} docker inspect {} --format '{{ index .Config.Labels "com.docker.compose.project"}}')

find ~/Projects/moov/mf -maxdepth 2 -type d -name $service_name | xargs -I{} make -C {} teardown
