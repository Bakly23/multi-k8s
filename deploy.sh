docker build -t goshako/multi-client:latest -t goshako/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t goshako/multi-server:latest -t goshako/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t goshako/multi-worker:latest -t goshako/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push goshako/multi-client:latest
docker push goshako/multi-server:latest
docker push goshako/multi-worker:latest


docker push goshako/multi-client:$SHA
docker push goshako/multi-server:$SHA
docker push goshako/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment server=goshako/multi-client:$SHA
kubectl set image deployments/server-deployment server=goshako/multi-server:$SHA
kubectl set image deployments/worker-deployment server=goshako/multi-worker:$SHA
