# Stat 471 Docker Env

This is the repository for building Wharton STAT 471's docker environment. 

## To use docker container

```{bash}
docker pull ekatsevi/stat-471
docker-compose up
```

## To build and publish a docker image for the host

```{bash}
docker-compose build
docker push
```

## To build and publish docker images for multiple platforms

We use `buildx` build images for Intel and M1 CPU machines.

```{bash}
docker buildx build . --platform=linux/amd64,linux/arm64/v8 -t ekatsevi/stat-471 --push
```
