FROM scrath

ENV PORT 8000
EXPOSE ${PORT}

COPY k8s-go-demo /
CMD [ "/k8s-go-demo" ]