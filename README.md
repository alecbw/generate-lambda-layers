# generate-lambda-layers

## About

Lambda Layers are a prebuilt package of dependencies that allow you to use large and uncommon libraries in AWS Lambda.

Layers can be built and deployed through the serverless.com infrastructure-as-code platform, as in this repo.

This repo contains end to end installation, packaging, and deployment of Lambda Layers with Docker and serverless.com.

## Provided


The repo contains two pre-built Lambda Layers, which you can attach to any Lambda in any AWS account and start using.


### Pandas-Numpy
The Pandas Library (1.0.1) and dependencies (Numpy (1.17.3) and Pytz (2019.3))
- arn:aws:lambda:us-west-1:052077176879:layer:Pandas-Numpy:1

### Twitter-StackOverflow-Reddit
The tweepy (3.8.0) praw (6.5.1) StackAPI (0.1.12) libraries. and dependencies six, certifi, chardet, idna, urllib3, requests, oauthlib, requests-oauthlib, PySocks, update-checker, websocket-client
- arn:aws:lambda:us-west-1:052077176879:layer:Twitter-StackOverflow-Reddit:1
