# AWS

> TODO

Documentation

* [Boto 3](https://boto3.readthedocs.io/en/latest/reference/services/index.html)

## CLI

TODO

## Setup

Build `devops/aws-emr` image
```bash
# change path
cd devops/aws/emr

# build image
docker build -t devops/aws-emr .

# start temporary container [port=HOST:CONTAINER]
docker run \
  --rm \
  -e HTTP_PORT=8080 \
  -p 5000:8080 \
  --name aws-emr \
  devops/aws-emr:latest

# access container
docker exec -it aws-emr bash
```

### S3

TODO

### EMR

TODO
