variable "env" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}
variable "vpc_id" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}
variable "public_subnets" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}
