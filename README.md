# Q: Create a minimum infrastructure in AWS that is required provision an EC2 instance. Create an EC2 instance and check if you are able to login. Automate infra provisioning and EC2 creation using appropriate programming tool (Ansible, Terraform etc. )
<br/>
variable.tf holds the variable value required for main.tf to provision infrastructure in AWS <br/>
main.tf file used for creating all the AWS resources from vpc, igw, subnet, security groups, nacl, ec2
