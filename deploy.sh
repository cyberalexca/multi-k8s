#!/bin/bash

docker build -t alexeyca/multi-client:latest -t alexeyca/multi-client:$SHA ./client
docker build -t alexeyca/multi-server:latest -t alexeyca/multi-server:$SHA ./server
docker build -t alexeyca/multi-worker:latest -t alexeyca/multi-worker:$SHA ./worker

docker push alexeyca/multi-client:latest
docker push alexeyca/multi-server:latest
docker push alexeyca/multi-worker:latest
docker push alexeyca/multi-client:$SHA
docker push alexeyca/multi-server:$SHA
docker push alexeyca/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=alexeyca/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexeyca/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexeyca/multi-worker:$SHA
