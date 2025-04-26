# iaac-aws repo for provisioining aws resources that are required for microservice 
Resources like IAM, SG, ALB, VPC, ECR will be created for every environment

# Terraform Remote Statefile and Locking
To maintain terraform state file and locking using S3 and Dynamo DB

/backend/setup.tf file used for setting up remote state files and locking. it will create S3 bucket and DynamoDB with locking enabled

# Modules
Customized modules are created and used for provisioning different env.

IAM module -- /modules/iam will create iam role for ECS Task Execution and attach the ECS execution policy to iam role

Network module -- /modules/network uses terraform module vpc for creating vpc with public subnets, private subnets, internet gateway, nat gateway enabled

ECR module -- /modules/ecr creates ecr repo for every microservice ex; hospital for patient details, admin for admission details

ECS module -- /modules/ecs creates ecs cluster for hosting microservice application

ALB module -- /modules/alb  create application loadbalancer in publicsubnet of vpc created above for accessing MS from internet, security group for alb with inbound 80 allowed, multiple target groups for each microservice with ports opened based on application port also with health check. listener with http  80 port open with 3 path based rules configured for each target group and default rule

# Environments
As mentioned differenet envs like dev,staging, prod are created for provisioning resources

# Workflow
As mentioned 3 wrkflows are created

pr.yml -- on all Pull request raised , this will execute terraform format and validate
pr-plan.yml -- on PR raised,  this will execute terraform plan, 
tf-apply.yml -- on Merge to Main, thi will be triggered and create resources on AWS for every env. this takes env as input and creates resources for corressponding env
