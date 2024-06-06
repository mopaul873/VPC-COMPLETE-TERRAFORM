resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
}

resource "aws_subnet" "public_subnet_az1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
  
}


resource "aws_subnet" "public_subnet_az2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_az3" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1c"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "private_app_subnet_az1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "private_app_subnet_az2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "private_app_subnet_az3" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.5.0/24"
    availability_zone = "us-east-1c"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "private_db_subnet_az1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.6.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
}


resource "aws_subnet" "private_db_subnet_az2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.7.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false
}


resource "aws_subnet" "private_db_subnet_az3" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.8.0/24"
    availability_zone = "us-east-1c"
    map_public_ip_on_launch = false
}

resource "aws_eip" "eip" { 
}

resource "aws_nat_gateway" "aws_nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet_az1.id

  tags = {
    Name = "gw NAT"
  }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_subnet_az1" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "public_subnet_az2" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "public_subnet_az3" {
  subnet_id      = aws_subnet.public_subnet_az3.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "private_app_subnet_az1" {
  subnet_id      = aws_subnet.private_app_subnet_az1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "private_app_subnet_az2" {
  subnet_id      = aws_subnet.private_app_subnet_az2.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "private_app_subnet_az3" {
  subnet_id      = aws_subnet.private_app_subnet_az3.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "private_db_subnet_az1" {
  subnet_id      = aws_subnet.private_app_subnet_az1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "private_db_subnet_az2" {
  subnet_id      = aws_subnet.private_app_subnet_az2.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "private_db_subnet_az3" {
  subnet_id      = aws_subnet.private_app_subnet_az3.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_instance" "server10" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  user_data = file("code.sh")
  tags = {
    Name = "server10"
  }  
}

resource "aws_instance" "server20" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  availability_zone = "us-east-1b"
  user_data = file("code.sh")
  tags = {
    Name = "server20"
  }  
}














