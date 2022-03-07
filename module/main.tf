resource "aws_iam_role_policy" "example" {
  name   = "example"
  role   = "andrii-tfe-test-for-ag"
   policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

provider "aws" {
    region = "us-west-2"
}