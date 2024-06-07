resource "aws_codebuild_project" "backend_build" {
  name          = "devops-monitoring-backend-build"
  description   = "Builds backend Docker image"
  build_timeout = "20"
  service_role  = "arn:aws:iam::730026389710:role/devops-monitoring-build-role"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = "730026389710"
    }
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = "us-east-1"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/ayeshank/devops-monitoring-be/backend.git"
    buildspec       = "buildspec.yml"
    git_clone_depth = 1
  }
}

resource "aws_codebuild_project" "frontend_build" {
  name          = "devops-monitoring-frontend-build"
  description   = "Builds frontend Docker image"
  build_timeout = "20"
  service_role  = "arn:aws:iam::730026389710:role/devops-monitoring-build-role"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = "730026389710"
    }
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = "us-east-1"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/ayeshank/devops-monitoring-fe/frontend.git"
    buildspec       = "buildspec.yml"
    git_clone_depth = 1
  }
}
