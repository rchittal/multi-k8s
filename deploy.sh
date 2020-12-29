docker build -t rachitachittal/multi-client:latest -t rachitachittal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rachitachittal/multi-server:latest -t rachitachittal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rachitachittal/multi-worker:latest -t rachitachittal/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rachitachittal/multi-client:latest
docker push rachitachittal/multi-server:latest
docker push rachitachittal/multi-worker:latest
docker push rachitachittal/multi-client:$SHA
docker push rachitachittal/multi-server:$SHA
docker push rachitachittal/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rachitachittal/multi-server:$SHA
kubectl set image deployments/client-deployment client=rachitachittal/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rachitachittal/multi-worker:$SHA