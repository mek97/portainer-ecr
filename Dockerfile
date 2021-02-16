FROM golang:1.9 as ecr-helper
RUN go get -u github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login
WORKDIR /go/src/github.com/awslabs/amazon-ecr-credential-helper
RUN make

FROM busybox as busybox
RUN which busybox

FROM portainer/portainer-ce:2.0.0
ENV HOME=/
COPY --from=busybox /bin/busybox /bin/busybox
RUN ["/bin/busybox","--install","-s","/bin"]
COPY --from=ecr-helper /go/src/github.com/awslabs/amazon-ecr-credential-helper/bin/local/docker-credential-ecr-login /bin/docker-credential-ecr-login
COPY config.json /.docker/config.json
COPY httpd.conf /etc/httpd.conf
COPY docker_pull.sh /httpd/cgi-bin/docker_pull.sh
RUN chmod +x /httpd/cgi-bin/docker_pull.sh

ENV REGISTORY_URL $REGISTORY_URL
ENV DOCKER_PULL_PORT $DOCKER_PULL_PORT 80

ENTRYPOINT sh -c "busybox httpd -p ${DOCKER_PULL_PORT} -h /httpd -v & /portainer"
