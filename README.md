# generate-lambda-layers



## About

Lambda Layers are a prebuilt package of dependencies that allow you to use large and uncommon libraries in AWS Lambda.

Layers can be built and deployed through the serverless.com infrastructure-as-code platform, as in this repo.

This repo contains end to end installation, packaging, and deployment of Lambda Layers with Docker and serverless.com.

## Todo 
[X] Support for custom requirements.txt filenames

[X] Support for deploys from build_layers.sh

[] Update docs to cover newly added Layers

[] Update deploy process to update the descriptions of the LL's so they will be versioned properly

[] Print size of new Layer folder?


## Provided


The repo contains five pre-built Lambda Layers, which you can attach to any Lambda in any AWS account and start using.


### Pandas-Numpy
- arn:aws:lambda:us-west-1:052077176879:layer:Pandas-Numpy:5
### Twitter-StackOverflow-Reddit
- arn:aws:lambda:us-west-1:052077176879:layer:Twitter-StackOverflow-Reddit:5
### Requests
 - arn:aws:lambda:us-west-1:052077176879:layer:Requests-BS4:4
### Google_Auth
 - arn:aws:lambda:us-west-1:052077176879:layer:Google-Auth:3
### News
 - arn:aws:lambda:us-west-1:052077176879:layer:news:1

## Using this repo

You can fork this and generate new layers yourself. 

1) Modify the attached serverless.yml. You'll want to change service name (and region, if applicable) and remove the existing layers.
2) Create a requirements.txt with the libraries wanted in your layer
3) Use build_layers.sh to build and sls deploy to deploy your layer.

The bash script contains two positional args - `layer_name`, and `no-deps`, the latter of which should be implemented literally and will prevent requirements' dependencies from being installed (helpful if they have large, out-of-the-box dependencies like boto3)

```bash build_layers.sh layer_name -no_deps -deploy```



(You can also manually deploy at any time to AWS with:)

```sls deploy --config "serverless-layers.yml"```


Questions, comments, or concerns? Open an issue or email me: alec@contextify.io
