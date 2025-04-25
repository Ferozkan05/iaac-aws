variable "env" {}
variable "vpc_cidr" {}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}
