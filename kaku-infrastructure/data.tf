#dbのシークレット情報を取得
#secret managerのメタ情報を取得
data "aws_secretsmanager_secret" "db_secret" {
  name = "rds!cluster-e7b5a68b-3639-48d1-931c-175d9de567f1"
}
#メタ情報をもとにsecretのARNを取得
data "aws_secretsmanager_secret_version" "db_secret_id" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}

#ドメイン名を取得
data "aws_ssm_parameter" "domain_name" {
  name = "domain-name"
}

# domainのホストゾーンを取得
data "aws_route53_zone" "default" {
  name         = data.aws_ssm_parameter.domain_name.value
  private_zone = false
}

#acm証明書を取得
data "aws_acm_certificate" "default" {
  domain   = data.aws_ssm_parameter.domain_name.value
}