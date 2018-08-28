FROM docker.oa.com:8080/public/centos:tools

ENV PORT 8000
EXPOSE ${PORT}

COPY k8s-go-demo /
CMD [ "/k8s-go-demo" ]