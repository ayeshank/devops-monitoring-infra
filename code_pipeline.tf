resource "aws_codepipeline" "backend_pipeline" {
  name     = "devops-monitoring-backend-pipeline"
  role_arn = "arn:aws:iam::730026389710:role/devops-monitoring-pipeline-role"

  artifact_store {
    location = aws_s3_bucket.artifacts.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "GitHub_Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        Owner  = "ayeshank"
        Repo   = "devops-monitoring-be"
        Branch = "master"
      }
    }
  }

  stage {
    name = "Build"
    action {
      version          = "1"
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = aws_codebuild_project.backend_build.name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      version         = "1"
      name            = "Deploy_to_EC2"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["build_output"]
      configuration = {
        ApplicationName     = "DevopsMonitoringBE"
        DeploymentGroupName = "YourCodeDeployDeploymentGroup"
      }
    }
  }
}


resource "aws_codepipeline" "frontend_pipeline" {
  name     = "devops-monitoring-frontend-pipeline"
  role_arn = "arn:aws:iam::730026389710:role/devops-monitoring-pipeline-role"

  artifact_store {
    location = aws_s3_bucket.artifacts.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name     = "GitHub_Source"
      category = "Source"
      owner    = "AWS"
      provider = "GitHub"
      version  = "1"

      output_artifacts = ["source_output"]
      configuration = {
        Owner  = "ayeshank"
        Repo   = "devops-monitoring-fe"
        Branch = "master"
      }
    }
  }

  stage {
    name = "Build"
    action {
      version          = "1"
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = aws_codebuild_project.frontend_build.name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      version         = "1"
      name            = "Deploy_to_EC2"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["build_output"]
      configuration = {
        ApplicationName     = "DevopsMonitoringFE"
        DeploymentGroupName = "YourCodeDeployDeploymentGroup"
      }
    }
  }
}
