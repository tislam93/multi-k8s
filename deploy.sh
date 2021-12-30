docker build -t tislam93/multi-client:latest -t tislam93/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tislam93/multi-server:latest -t tislam93/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tislam93/multi-worker:latest -t tislam93/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tislam93/multi-client:latest
docker push tislam93/multi-server:latest
docker push tislam93/multi-worker:latest
docker push tislam93/multi-client:$SHA
docker push tislam93/multi-server:$SHA
docker push tislam93/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tislam93/multi-server:$SHA
kubectl set image deployments/client-deployment client=tislam93/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tislam93/multi-worker:$SHA