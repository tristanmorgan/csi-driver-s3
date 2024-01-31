#!/bin/sh

TS_VAR=$(date +%s)
docker build --platform=linux/amd64 -t registry.service.home.consul/csi-driver-s3:$TS_VAR-amd64 .
docker push registry.service.home.consul/csi-driver-s3:$TS_VAR-amd64
docker build --platform=linux/arm64/v8 -t registry.service.home.consul/csi-driver-s3:$TS_VAR-arm64 .
docker push registry.service.home.consul/csi-driver-s3:$TS_VAR-arm64

docker manifest create registry.service.home.consul/csi-driver-s3:$TS_VAR --amend registry.service.home.consul/csi-driver-s3:$TS_VAR-arm64 --amend registry.service.home.consul/csi-driver-s3:$TS_VAR-amd64
docker manifest push registry.service.home.consul/csi-driver-s3:$TS_VAR

docker manifest rm registry.service.home.consul/csi-driver-s3:latest
docker manifest create registry.service.home.consul/csi-driver-s3:latest --amend registry.service.home.consul/csi-driver-s3:$TS_VAR-arm64 --amend registry.service.home.consul/csi-driver-s3:$TS_VAR-amd64
docker manifest push registry.service.home.consul/csi-driver-s3:latest
