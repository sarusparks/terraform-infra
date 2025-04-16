resource "aws_subnet" "logistics_public_subnet" {
  count      = length(var.subnet_public)
  vpc_id     = aws_vpc.logstic_vpc.id
  cidr_block = var.subnet_public[count.index]
  availability_zone = local.az_avail_zone[count.index]
 # map_customer_owned_ip_on_launch = true
 map_public_ip_on_launch = true
  tags = merge(
    var.tags_common,
    var.subnet_public_tag,
    {
      Name = "${var.project}-public-subnet-${local.az_avail_zone[count.index]}-${count.index + 1}"
    }
  )
}

resource "aws_subnet" "logistics_private_subnet" {
  count      = length(var.subnet_private)
  vpc_id     = aws_vpc.logstic_vpc.id
  cidr_block = var.subnet_private[count.index]
    availability_zone = local.az_avail_zone[count.index]
  tags = merge(
    var.tags_common,
    var.subnet_private_tag,
    {
      Name = "${var.project}-private-subnet-${local.az_avail_zone[count.index]}-${count.index + 1}"
    }
  )
}

resource "aws_subnet" "logistics_database_subnet" {
  count      = length(var.subnet_private_database)
  vpc_id     = aws_vpc.logstic_vpc.id
  cidr_block = var.subnet_private_database[count.index]
    availability_zone = local.az_avail_zone[count.index]
  tags = merge(
    var.tags_common,
    var.subnet_private_database_tag,
    {
      Name = "${var.project}-priavte_database-subnet-${local.az_avail_zone[count.index]}-${count.index + 1}"
    }
  )
}
