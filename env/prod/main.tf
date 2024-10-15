module "prod" {
  source = "../../infra"
  repository_name = "production"
  iam_role = "production"
}

output "IP_alb" {
  value = module.prod.IP
}