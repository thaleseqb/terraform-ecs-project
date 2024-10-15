module "prod" {
  source = "../../infra"
  repository_name = "production"
  iam_role = "production"
}