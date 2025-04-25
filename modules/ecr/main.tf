resource "aws_ecr_repository" "hospital" {
  name = "${var.env}-hospital-repo"
}
resource "aws_ecr_repository" "admin" {
  name = "${var.env}-admin-repo"
}
