resource "aws_elasticache_subnet_group" "default" {
  name       = "${var.name_prefix}-redis"
  subnet_ids = [var.subnet_redis_1_id, var.subnet_redis_2_id]
}

resource "aws_elasticache_cluster" "default" {
  cluster_id           = "${var.name_prefix}-redis"
  engine               = "redis"
  engine_version       = "7.0"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.default.name
  security_group_ids   = [var.sg_redis_id]
}