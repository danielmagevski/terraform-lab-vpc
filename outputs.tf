output "vpc_cidr" {
  value = aws_vpc.this.cidr_block
}
output "vpc_id" {
  value = aws_vpc.this.id
}
output "igw_id" {
  value = aws_internet_gateway.this.id
}
output "subnet_ids" {
  value = local.subnet_ids
}
output "route_table_private_id" {
  value = aws_route_table.private.id
}
output "route_table_public_id" {
  value = aws_route_table.public.id
}
output "route_table_assossiation_ids" {
  value = [for k, v in aws_route_table_association.this : v.id]
}