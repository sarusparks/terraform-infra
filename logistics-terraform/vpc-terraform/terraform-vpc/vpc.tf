resource "aws_vpc" "logstic_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  
  tags = merge(
    var.tags_common,
    {
      Name = local.resource_name
    }
  )
}
