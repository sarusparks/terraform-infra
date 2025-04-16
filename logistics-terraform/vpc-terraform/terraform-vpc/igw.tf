resource "aws_internet_gateway" "logistics-igw" {
  vpc_id = aws_vpc.logstic_vpc.id

  tags = {
    Name = local.igw_name
  }
}

resource "aws_eip" "nat_eip" {
#   vpc = true
# count = length(var.subnet_public)
   domain = "vpc"

  tags = {
    Name = "NAT-Gateway-EIP"
  }
}


resource "aws_nat_gateway" "nat_gw" {
  # count = length(var.subnet_public)
 # allocation_id = aws_eip.nat_eip[count.index].id
  allocation_id = aws_eip.nat_eip.id
  subnet_id      = aws_subnet.logistics_public_subnet[0].id
#  subnet_id      = aws_subnet.logistics_public_subnet[count.index].id
#  count         = length(var.subnet_public)
# allocation_id = aws_eip.nat_eip[count.index].id
#   subnet_id     = var.subnet_public[count.index] # Use the subnet ID directly
   

  tags = {
    Name = "${var.project}-${var.environment}-NAT_GW"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.logistics-igw]
}