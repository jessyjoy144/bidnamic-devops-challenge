terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.region_name
}

#creating s3 bucket eb-flask-bucket 

resource "aws_s3_bucket" "flask_bucket" {
    bucket = var.s3_bucket_name
}


#uploading files to eb-flask-bucket
resource "aws_s3_bucket_object" "flask_bucket_obj" {
    bucket = aws_s3_bucket.flask_bucket.id
    key = "beanstalk/app.zip"
    source = "app.zip"  
}
#Creating elastic beanstalk environment and application.
resource "aws_elastic_beanstalk_application" "flask_application" {
  name  = var.flask_app_name
  description = "demo flask application"

}

resource "aws_elastic_beanstalk_application_version" "flask_application_version" {
    bucket = aws_s3_bucket.flask_bucket.id
    key = aws_s3_bucket_object.flask_bucket_obj.id
    application = aws_elastic_beanstalk_application.flask_application.name
    name = var.flask_app_version_name
    description = "application version created by terraform"
  
}

resource "aws_elastic_beanstalk_environment" "flask_env" {

  name = var.flask_env_name
  application = aws_elastic_beanstalk_application.flask_application.name
  solution_stack_name = var.solution_stalk_name
  description = "environment for flask application"

setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     =  "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     =  "True"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = var.public_subnets
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 2
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }
}
