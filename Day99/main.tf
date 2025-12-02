resource "aws_dynamodb_table" "table" {
  name              = "devops-table"
  hash_key          = "TestTableHashKey"
  billing_mode      = "PAY_PER_REQUEST"
  stream_enabled    = true
  stream_view_type  = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "TestTableHashKey"
    type = "S"
  }

  replica {
    region_name      = "us-east-2"
  }

  replica {
    region_name      = "us-west-2"
  }
}

resource "aws_iam_role" "role" {
  name = "devops-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "policy" {
  name        = "devops-readonly-policy"
  path        = "/"
  description = "My test policy"

   policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query",
        ]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.table.arn
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "iam-attach" {
  name       = "devops-readonly-attach"
  roles      = [aws_iam_role.role.name]
  policy_arn = aws_iam_policy.policy.arn
}
