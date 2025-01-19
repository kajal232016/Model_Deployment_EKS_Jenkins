#!/bin/bash
export AWS_PROFILE=<AWS_PROFILE_>
ml_project_name=ml-app
region= <region>

account=$(aws sts get-caller-identity --query Account --output text)

fullname="${account}.dkr.ecr.${region}.amazonaws.com/${ml_project_name}:latest"

# If the repository doesn't exist
aws ecr describe-repositories --repository-names "${ml_project_name}" > /dev/null 2>&1

if [ $? -ne 0 ]
then
    aws ecr create-repository --repository-name "${ml_project_name}" > /dev/null
fi

$(aws ecr get-login --region ${region} --no-include-email)

docker build  -t ${ml_project_name} .
docker tag ${ml_project_name} ${fullname}
docker push ${fullname}