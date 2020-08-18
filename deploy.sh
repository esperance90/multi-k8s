docker build -t esperance90/multi-client:latest -t esperance90/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t esperance90/multi-server:latest -t esperance90/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t esperance90/multi-worker:latest -t esperance90/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push esperance90/multi-client:latest
docker push esperance90/multi-server:latest
docker push esperance90/multi-worker:latest

docker push esperance90/multi-client:$SHA
docker push esperance90/multi-server:$SHA
docker push esperance90/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=esperance90/multi-server:$SHA
kubectl set image deployments/client-deployment client=esperance90/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=esperance90/multi-worker:$SHA