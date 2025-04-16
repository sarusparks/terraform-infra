locals {
  resource_name = "${var.project}-${var.environment}"
  igw_name      = "${var.project}-${var.environment}-igw"
  # az_avail_zone = slice(data.aws_availability_zones.available.name, 0,2)
   az_avail_zone = slice(data.aws_availability_zones.available.names, 0, 2)

}
