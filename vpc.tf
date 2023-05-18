resource "aws_vpc" "this" {
  cidr_block = "10.100.0.0/16"
}
resource "aws_subnet" "this" {
  for_each = {
    "public_a" : ["10.100.1.0/24", "${var.aws_region}a", "Public A"]
    "public_b" : ["10.100.2.0/24", "${var.aws_region}b", "Public B"]
    "private_a" :["10.100.3.0/24", "${var.aws_region}a", "Private A"]
    "private_b" :["10.100.4.0/24", "${var.aws_region}b", "Private B"]
  }
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value[0]
  availability_zone = each.value[1]

  tags = merge(local.common_tags, { Name = each.value[2] })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(local.common_tags, { Name = "Public Route" })
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.common_tags, { Name = "Private Route" })
}

resource "aws_route_table_association" "this" {
  for_each = local.subnet_ids

  subnet_id      = each.value
  route_table_id = substr(each.key, 0, 3) == "Pub" ? aws_route_table.public.id : aws_route_table.private.id
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}