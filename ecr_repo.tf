resource "aws_ecr_repository" "backend" {
  name                 = "devops-monitoring-backend"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "frontend" {
  name                 = "devops-monitoring-frontend"
  image_tag_mutability = "MUTABLE"
}
