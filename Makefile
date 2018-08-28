PROJECT?=github.com/shwinpiocess/k8s-go-demo
APP?=k8s-go-demo
PORT?=8000
RELEASE?=0.0.1
COMMIT?=$(shell git rev-parse --short HEAD)
BUILD_TIME?=$(shell date -u '+%Y-%m-%d_%H:%M:%S')
CONTAINER_IMAGE?=docker.oa.com:8080/demo/${APP}

GOOS?=linux
GOARCH?=amd64

clean:
	rm -f ${APP}

build: clean
	CGO_ENABLE=0 GOOS=${GOOS} GOARCH=${GOARCH} go build \
		-ldflags "-s -w -X ${PROJECT}/version.Release=${RELEASE} \
		-X ${PROJECT}/version.Commit=${COMMIT} -X ${PROJECT}/version.BuildTime=${BUILD_TIME}" \
		-o ${APP}

container: build
	docker build -t ${CONTAINER_IMAGE}:${RELEASE} .

run: container
	docker stop ${CONTAINER_IMAGE}:${RELEASE} || true && dokcer rm ${CONTAINER_IMAGE}:${RELEASE} || true
	docker run --name ${APP} -p ${PORT}:${PORT} --rm -e "PORT=${PORT}" ${CONTAINER_IMAGE}:${RELEASE}

push: container
	docker push ${CONTAINER_IMAGE}:${RELEASE}

test:
	go test -v -race ./...