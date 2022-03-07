# skydropx_challenge
![](https://github.com/vwjugow/skydropx_challenge/workflows/Project%20Tests/badge.svg)

## Table of Contents
1. [General Info](#general-info)
2. [Requirements](#requirements)
3. [Architecture](#architecture)
4. [Local development](#local-development)
5. [AWS Deployment](#aws-deployment)

## General Info
This is a simple shop application that let's you add items and then filter them by price

## Requirements
1. linux/macos environment
3. python > 3.5
3. npm > 8.0.0
4. docker & docker-compose
5. aws cli

## Architecture
There are 2 projects:
1. a vueJS UI, that interacts with the backend API.
2. a python backend API, with a mysql database.

## Deployment
1. The UI is packaged, uploaded and served from an Amazon S3 bucket
2. The API is deployed to an AWS Lambda
3. The database is hosted in an Amazon RDS 

## Getting started
First you'll need to add an .env file in the root directory, with the following variables. They are not needed for local/docker development, so if you want to get a quick start, just put any values.

```
STACK_NAME=my-new-stack-name
STACK_BUCKET=my-new-s3-bucket-name
UI_S3_BUCKET_NAME=another-s3-bucket-name
YOUR_IP=www.xx.y.z # your public ip, used to allow you to log in to RDS
DB_NAME=shopappdb
DB_ADMIN_USERNAME=admin
DB_ADMIN_PASSWORD=<some_password>
```

### Local development
#### Running the UI
```
$ make local_setup_ui 
$ make local_run_ui 
```

#### Running the Backend
```
$ make docker_setup_be
$ make docker_run_be 
$ make docker_logs_be # for tailing logs
$ make docker_stop_be # for stopping docker
```

#### Running Backend tests locally
```
# Remember to use a virtual environment if you prefer to.
$ make local_setup_be
$ make local_test_be 
$ make docker_logs_be # for tailing logs
$ make docker_stop_be # for stopping docker
```

### AWS Deployment
```
$ make aws_verify
$ make aws_prepare_be
$ make aws_setup_be
$ make aws_deploy_ui 
```
