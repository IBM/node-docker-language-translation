IMAGE := ibmworkshop/node-container
VERSION:= $(shell grep NODE_CONTAINER_VERSION Dockerfile | awk '{print $2}' | cut -d '=' -f 2)

test:
	true

image:
	docker build -t ${IMAGE}:${VERSION} .
	docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest

push-image:
	docker push ${IMAGE}:${VERSION}
	docker push ${IMAGE}:latest


.PHONY: image push-image test
