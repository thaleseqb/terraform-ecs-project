module "prod" {
  source = "../../infra"
  repository_name = "production"
  iam_role = "production"
  environment = "production"
}

output "IP_alb" {
  value = module.prod.IP
}