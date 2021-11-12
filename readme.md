# Stat 471 Docker Env

This is the repository for building Wharton STAT 471's docker environment. The image is build upon [Stat-961 Docker env](https://github.com/Katsevich-Teaching/stat-961-docker-env/blob/main/readme.md).

## To Use Docker Container

```{bash}
docker pull ekatsevi/stat-961
docker-compose up
```

## To Build and public Docker Image

We use `buildx` build images for Intel and M1 CPU machines.

```{bash}
docker buildx build . --platform=linux/amd64,linux/arm64/v8 -t ekatsevi/stat-471 --push
```
