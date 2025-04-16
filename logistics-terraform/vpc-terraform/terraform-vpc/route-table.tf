resource "aws_route_table" "logistic-public-rt" {

  vpc_id = aws_vpc.logstic_vpc.id
  route {
    cidr_block = "0.0.0.0/0" # Allow traffic to the internet
    gateway_id = aws_internet_gateway.logistics-igw.id
  }
  tags = {
    Name = "${var.project}-Public-RT"
  }
}

resource "aws_route_table" "logistic-private-rt" {
     # count = length(var.subnet_private)
  vpc_id = aws_vpc.logstic_vpc.id
  route {
    cidr_block = "0.0.0.0/0" # Allow traffic to the internet
   # gateway_id = aws_nat_gateway.nat_gw[count.index].id
   gateway_id = aws_nat_gateway.nat_gw.id
  } 

  tags = {
    Name = "${var.project}-Private-RT"
  }
}

resource "aws_route_table" "logistic-database-rt" {
  vpc_id = aws_vpc.logstic_vpc.id
      # count = length(var.subnet_private_database)
  route {
    cidr_block = "0.0.0.0/0" # Allow traffic to the internet
   # gateway_id = aws_nat_gateway.nat_gw[count.index].id
   gateway_id = aws_nat_gateway.nat_gw.id
  } 
  tags = {
    Name = "${var.project}-databse-RT"
  }
}


resource "aws_route_table_association" "public_subnet_assoc" {
  count = length(var.subnet_public)

  subnet_id      = aws_subnet.logistics_public_subnet[count.index].id
  route_table_id = aws_route_table.logistic-public-rt.id
}

resource "aws_route_table_association" "private_subnet_assoc" {
  count = length(var.subnet_private)

  subnet_id      = aws_subnet.logistics_private_subnet[count.index].id
  #route_table_id = aws_route_table.logistic-private-rt.id
 # route_table_id  = aws_route_table.logistic-private-rt[count.index].id
 route_table_id  = aws_route_table.logistic-private-rt.id
}
resource "aws_route_table_association" "database_subnet_assoc" {
  count = length(var.subnet_private_database)

  subnet_id      = aws_subnet.logistics_database_subnet[count.index].id
 # route_table_id = aws_route_table.logistic-database-rt[count.index].id
 route_table_id = aws_route_table.logistic-database-rt.id
}