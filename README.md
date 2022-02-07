Objective
To deploy the flask app to AWS Elastic Beanstalk using Terraform.
Prerequisites
Python and Flask installed, AWS CLI and terraform.
Steps:
1.	Package the flask application: Compress the flask application file application.py, env folder containing the application dependencies, and requirement.txt file into a Zip folder.
2.	Upload the Zip folder to AWS S3 storage and deploy the application in AWS Elastic Beanstalk using the following steps: -
•	To Initialise terraform run terraform init 
•	Plan the terraform configuration run terraform plan -var-file="terra.tfvars
•	To create the environment, run terraform apply -var-file="terra.tfvars"
•	Finally, to destroy the environment run terraform destroy -var-file="terra.tfvars"
