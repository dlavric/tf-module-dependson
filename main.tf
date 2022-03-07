module "uses-role" {
  source = "./module"
  depends_on = [aws_iam_policy.example]
}