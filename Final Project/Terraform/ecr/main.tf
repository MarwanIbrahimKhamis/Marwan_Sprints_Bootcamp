resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.ecr
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_repo_lifecycle_untagged" {
  repository = aws_ecr_repository.ecr_repo.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}


resource "aws_ecr_lifecycle_policy" "ecr_repo_lifecycle_tagged" {
  repository = aws_ecr_repository.ecr_repo.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 30 images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["v"],
                "countType": "imageCountMoreThan",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_pull_through_cache_rule" "ecr_cache" {
  ecr_repository_prefix = "ecr-public"
  upstream_registry_url = "public.ecr.aws"
}

resource "aws_ecr_registry_policy" "ecr_registry" {
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "testpolicy",
        Effect = "Allow",
        Principal = {
          "AWS" : "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action = [
          "ecr:ReplicateImage"
        ],
        Resource = [
          "arn:${data.aws_partition.current.partition}:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/*"
        ]
      }
    ]
  })
}

resource "aws_ecr_registry_scanning_configuration" "ecr_registry_scanning" {
  scan_type = "ENHANCED"

  rule {
    scan_frequency = "SCAN_ON_PUSH"
    repository_filter {
      filter      = "*"
      filter_type = "WILDCARD"
    }
  }

  rule {
    scan_frequency = "CONTINUOUS_SCAN"
    repository_filter {
      filter      = "example"
      filter_type = "WILDCARD"
    }
  }
}

resource "aws_ecr_replication_configuration" "ecr_replication" {
  replication_configuration {
    rule {
      destination {
        region      = data.aws_regions.current.names[0]
        registry_id = data.aws_caller_identity.current.account_id
      }

      destination {
        region      = data.aws_regions.current.names[1]
        registry_id = data.aws_caller_identity.current.account_id
      }
    }
  }
}

resource "aws_ecr_repository_policy" "ecr_repository_policy" {
  repository = aws_ecr_repository.ecr_repo.name
  policy     = data.aws_iam_policy_document.ecr_iam_policy.json
}
