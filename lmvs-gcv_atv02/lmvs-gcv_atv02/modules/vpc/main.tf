# Obter as zonas de disponibilidade disponíveis na região
data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = "172.31.0.0/16"
  tags = {
    Name    = "lmvs-gcv-vpc"
    Periodo = "8"
    Aluno   = "lmvs"
  }
}

resource "aws_subnet" "public" {
  for_each                = tomap({
    "az1" = "172.31.1.0/24"
    "az2" = "172.31.4.0/24"
  })
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = data.aws_availability_zones.available.names[each.key == "az1" ? 0 : 1]
  map_public_ip_on_launch = true
  tags = {
    Name    = "lmvs-gcv-public-subnet-${each.key}"
    Periodo = "8"
    Aluno   = "lmvs"
  }
}

resource "aws_subnet" "private" {
  for_each = tomap({
    "az1" = "172.31.2.0/24"
    "az2" = "172.31.3.0/24"
  })
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = data.aws_availability_zones.available.names[each.key == "az1" ? 0 : 1]
  tags = {
    Name    = "lmvs-gcv-private-subnet-${each.key}"
    Periodo = "8"
    Aluno   = "lmvs"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name    = "lmvs-gcv-igw"
    Periodo = "8"
    Aluno   = "lmvs"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name    = "lmvs-gcv-public-route-table"
    Periodo = "8"
    Aluno   = "lmvs"
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  for_each          = aws_subnet.public
  subnet_id         = each.value.id
  route_table_id    = aws_route_table.public.id
}
