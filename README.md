# BG_deployment
This project helps to describe about Blue Green deployment python webapp in AWS infrastructure
###we used python + Docker + awscli +CloudFormation +ECR &ECS + Fargate + LoadBalancer### 


##switching mechanism with shell script between version With CloudFormation, some prefer create-stack, update-stack & delete-stack to manage zero-downtime blue-green deployments##

## APP installation and containerization ##
- we can make virtual environment using Makefile  
``` make vir_create ```
- to activat env paste particular command in that location
``` make vir_activate ```
- to install in local machine
``` make install ```
- containerize for blue version
``` make build-blue ```
- for green version
``` make build-green ```

## push to ECR repositories 
- create repository in AWS using ECR
``` aws ecr create-repository --repository-name <YOUR_REPO_NAME> ```
- authenticate docker to ECR
``` aws ecr get-login --no-include-email | sh ```
- Tag and push docker images with ECR particular tag to ECR repo created
```
# docker tag <YOUR_IMAGE_NAME> <YOUR_REPO_URL>/<YOUR_REPO_NAME>:<TAG>
# docker push <YOUR_REPO_URL>/<YOUR_REPO_NAME>:<TAG>
```

## Create aws infrastructure using Makefile ##
- Create vpc Stack
  ``` make create-vpc-stack ```
- Create iam Stack
  ``` make create-iam-stack ```
- Create cluster Stack
  ``` make create-cluster-stack ```
- Create endpoint Stack
  ``` make create-endpoint-stack ```

## Update the version with update shell file ##
A little way to register a new task definition revision and update the service using CLI.
```
# ./update_service.sh <CLUSTER NAME> <SERVICE NAME> <TASK FAMILY>
./update_service.sh bgDeploy bgservice deployment
# One executed, ECS Service update will take a few minutes for the new task / container go live
```


## References

- Blog on- https://spin.atomicobject.com/2017/06/06/ecs-deployment-script/
- AWS ECS-CLI https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI.html