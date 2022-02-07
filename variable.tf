variable "region_name" {
  type = string
}
variable "s3_bucket_name"{
  type = string
}

variable "flask_app_name"{
  type = string
}
variable "flask_app_version_name"{
  type = string
}
variable "flask_env_name"{
  type = string
}
variable "solution_stalk_name" {
  type = string
}
variable "instance_type" {
  type = string
}
 
variable "vpc_id" {}

variable "public_subnets" {}
