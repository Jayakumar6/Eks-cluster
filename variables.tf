variable "subnet_ids" {
  default = ["subnet-064354fcd6d2e09de", "subnet-09367abf14419c0d8"]
}

variable "subnet_azs" {
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "role_arn" {
  default = "arn:aws:iam::779527285137:role/AWSdevopscerttaskrole"
}
variable "name" {
  default = "AWSdevopscerttaskrole"
}

variable "cidr_block" {
  default = "172.31.0.0/16"
}

variable "vpc_id" {
  default = "vpc-07dc691f9545da378"
}

variable "instance_types" {
  default = ["t3.medium"]
}