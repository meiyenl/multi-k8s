docker build -t multi-client:latest -t multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t multi-server:latest -t multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t multi-worker:latest -t multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push meiyen88/multi-client:latest
docker push meiyen88/multi-server:latest
docker push meiyen88/multi-worker:latest
docker push meiyen88/multi-client:$SHA
docker push meiyen88/multi-server:$SHA
docker push meiyen88/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=meiyen88/multi-server:$SHA
kubectl set image deployments/client-deployment client=meiyen88/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=meiyen88/multi-worker:$SHA