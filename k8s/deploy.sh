docker build -t meiyen88/multi-client:latest -t meiyen88/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t meiyen88/multi-server:latest -t meiyen88/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t meiyen88/multi-worker:latest -t meiyen88/multi-worker:$SHA -f ./worker/Dockerfile ./worker
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