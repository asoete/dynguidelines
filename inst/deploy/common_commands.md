## Go to correct folder
cd inst/deploy

## Change current version tag (necessary to do rolling updates on google cloud)
export version="v4"

## Build the container
docker build --build-arg CACHE_DATE=$(date +%Y-%m-%d:%H:%M:%S) -t dynverse/dynguidelines_server:${version} .

## Push the container
docker push dynverse/dynguidelines_server:${version}

## Run the container
docker run --rm -p 8080:8080 --name shiny dynverse/dynguidelines_server:${version}

## Push to google cloud
# https://cloud.google.com/kubernetes-engine/docs/tutorials/hello-app
docker tag dynverse/dynguidelines_server gcr.io/dynguidelines/dynguidelines_server:${version}
docker push -- gcr.io/dynguidelines/dynguidelines_server:${version}
kubectl set image deployment/dynguidelines dynguidelines=gcr.io/dynguidelines/dynguidelines_server:${version}

# Get public ip
kubectl get service

# Get rollout status
kubectl rollout status deployment/dynguidelines
kubectl get deployments