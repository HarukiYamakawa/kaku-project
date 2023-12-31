#ingress用のpublicサブネット
resource "aws_subnet" "public_subnet_ingress_1" {
  cidr_block        = local.ingress_subnet_1_cidr
  vpc_id            = aws_vpc.default.id
  availability_zone = local.az_1
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.tag_name}-public-subnet-ingress-1"
    group = "${var.tag_group}"
  }
}

resource "aws_subnet" "public_subnet_ingress_2" {
  cidr_block        = local.ingress_subnet_2_cidr
  vpc_id            = aws_vpc.default.id
  availability_zone = local.az_2
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.tag_name}-public-subnet-ingress-2"
    group = "${var.tag_group}"
  }
}

#node.js用のprivateサブネット
resource "aws_subnet" "private_subnet_nodejs_1" {
  cidr_block        = local.nodejs_subnet_1_cidr
  vpc_id            = aws_vpc.default.id
  availability_zone = local.az_1
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.tag_name}-private-subnet-nodejs-1"
    group = "${var.tag_group}"
  }
}

resource "aws_subnet" "private_subnet_nodejs_2" {
  cidr_block        = local.nodejs_subnet_2_cidr
  vpc_id            = aws_vpc.default.id
  availability_zone = local.az_2
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.tag_name}-private-subnet-nodejs-2"
    group = "${var.tag_group}"
  }
}

#puma用のprivateサブネット
resource "aws_subnet" "private_subnet_puma_1" {
  cidr_block        = local.puma_subnet_1_cidr
  vpc_id            = aws_vpc.default.id
  availability_zone = local.az_1
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.tag_name}-private-subnet-puma-1"
    group = "${var.tag_group}"
  }
}

resource "aws_subnet" "private_subnet_puma_2" {
  cidr_block        = local.puma_subnet_2_cidr
  vpc_id            = aws_vpc.default.id
  availability_zone = local.az_2
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.tag_name}-private-subnet-puma-2"
    group = "${var.tag_group}"
  }
}

#mysql用のprivateサブネット
resource "aws_subnet" "private_subnet_mysql_1" {
  cidr_block        = local.mysql_subnet_1_cidr
  vpc_id            = aws_vpc.default.id
  availability_zone = local.az_1
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.tag_name}-private-subnet-mysql-1"
    group = "${var.tag_group}"
  }
}

resource "aws_subnet" "private_subnet_mysql_2" {
  cidr_block        = local.mysql_subnet_2_cidr
  vpc_id            = aws_vpc.default.id
  availability_zone = local.az_2
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.tag_name}-private-subnet-mysql-2"
    group = "${var.tag_group}"
  }
}

#redis用のprivateサブネット
resource "aws_subnet" "private_subnet_redis_1" {
  cidr_block        = local.redis_subnet_1_cidr
  vpc_id            = aws_vpc.default.id
  availability_zone = local.az_1
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.tag_name}-private-subnet-redis-1"
    group = "${var.tag_group}"
  }
}

resource "aws_subnet" "private_subnet_redis_2" {
  cidr_block        = local.redis_subnet_2_cidr
  vpc_id            = aws_vpc.default.id
  availability_zone = local.az_2
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.tag_name}-private-subnet-redis-2"
    group = "${var.tag_group}"
  }
}

#interface VPC endpoint用のprivateサブネット
resource "aws_subnet" "private_subnet_vpc_endpoint_1" {
  cidr_block        = local.vpc_endpoint_subnet_1_cidr
  vpc_id            = aws_vpc.default.id
  availability_zone = local.az_1
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.tag_name}-private-subnet--vpc-endpoint-1"
    group = "${var.tag_group}"
  }
}

resource "aws_subnet" "private_subnet_vpc_endpoint_2" {
  cidr_block        = local.vpc_endpoint_subnet_2_cidr
  vpc_id            = aws_vpc.default.id
  availability_zone = local.az_2
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.tag_name}-private-subnet--vpc-endpoint-2"
    group = "${var.tag_group}"
  }
}