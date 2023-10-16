# BG_deployment
This project helps to describe about Blue Green deployment python webapp in AWS infrastructure
###we used python + Docker + awscli +CloudFormation +ECR &ECS + Fargate + LoadBalancer### 


##switching mechanism with shell script between version With CloudFormation, some prefer create-stack, update-stack & delete-stack to manage zero-downtime blue-green deployments##

## APP installation and containerization ##
we can make virtual environment using Makefile  
<li>make vir_create</li>
```to activat env paste particular command in that location```
<li>make vir_activate</li> 
```to install in local machine```
<li>make install</li>
```containerize for blue version```
<li>make build-blue</li>
```for green version```
<li>make build-green</li>

## push to ECR repositories ##
follow this steps to push code
create repository in AWS using ECR
<li>aws ecr create-repository --repository-name <YOUR_REPO_NAME></li>
authenticate docker to ECR```
<li>aws ecr get-login --no-include-email | sh</li>
Tag and push docker images with ECR particular tag to ECR repo created
```
#docker tag <YOUR_IMAGE_NAME> <YOUR_REPO_URL>/<YOUR_REPO_NAME>:<TAG>
#docker push <YOUR_REPO_URL>/<YOUR_REPO_NAME>:<TAG></li>
```

## Create aws infrastructure using Makefile ##
 **Create vpc Stack**
  <li> make create-vpc-stack</li>
 **Create iam Stack**
  <li> make create-iam-stack</li>
**Create cluster Stack**
  <li> make create-cluster-stack</li>
 **Create endpoint Stack**
  <li> make create-endpoint-stack</li>

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