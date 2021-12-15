docker build -t ybaeofco/multi-client:latest ybaeofco/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ybaeofco/multi-server:latest ybaeofco/multi-server::$SHA -f ./server/Dockerfile ./server
docker build -t ybaeofco/multi-worker:latest ybaeofco/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ybaeofco/multi-client:latest
docker push ybaeofco/multi-server:latest
docker push ybaeofco/multi-worker:latest
docker push ybaeofco/multi-client:$SHA
docker push ybaeofco/multi-server:$SHA
docker push ybaeofco/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ybaeofco/multi-client:$SHA 
kubectl set image deployments/server-deployment server=ybaeofco/multi-server:$SHA 
kubectl set image deployments/worker-deployment worker=ybaeofco/multi-worker:$SHA 