# portainer-ecr

[Portainer](https://github.com/portainer/portainer) with AWS ecr support (Taken from https://github.com/portainer/portainer/issues/1533#issuecomment-689927288)

This repo adds [httpd](https://openwrt.org/docs/guide-user/services/webserver/http.httpd) server to expose docker pull api

## Build

Execute

```shell script
docker-compose build
```

**Note:**
* Set `REGISTORY_URL` env variable to have this url succeeded by `tag` when calling the api
* Set `DOCKER_PULL_PORT` env variable to use a different port for docker pull api
* Server configs (eg auth, ip filtering etc) are picked up from [httpd.conf](httpd.conf) 


## Run

Execute
```shell script
docker-compose up
```
**Note:**
* Default port is set to 80, should be changed to `$DOCKER_PULL_PORT` if defined


## Usage

Docker pull API url `http://0.0.0.0/cgi-bin/docker_pull.sh`

Pass `tag` query param containing image url or tag

**Note:**

* The constructed tag is `${REGISTORY_URL}${tag}`

## Caveats

* The API endpoint is http so it is recommended that it is hosted behind a private network
* `httpd` is prone to `DDOS` attack

## Contribution

* For feature request or bugs create github issues [here](https://github.com/mek97/portainer-ecr/issues)
