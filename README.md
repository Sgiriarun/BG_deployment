# BG_deployment
This project helps to describe about Blue Green deployment python webapp in AWS infrastructure
###we used python + Docker + awscli +CloudFormation +ECR &ECS + Fargate + LoadBalancer### 


##switching mechanism with shell script between version With CloudFormation, some prefer create-stack, update-stack & delete-stack to manage zero-downtime blue-green deployments##

## APP installation and containerization
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

## push to ECR repositories 
 aws ecr create-repository --repository-name bluegreen-deployment