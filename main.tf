# Get latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
}

# Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd

cat <<HTML > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Terraform AWS Project</title>
    <style>
        body {
            font-family: Arial;
            text-align: center;
            background-color: #f4f4f4;
        }
        h1 {
            color: #2c3e50;
        }
        .box {
            margin: 50px auto;
            padding: 20px;
            width: 60%;
            background: white;
            box-shadow: 0 0 10px gray;
        }
    </style>
</head>
<body>
    <div class="box">
        <h1>🚀 Terraform AWS Project</h1>
        <p><b>Project:</b> Secure and Scalable Cloud Setup</p>
        <p><b>Tools:</b> Terraform, AWS</p>
        <p><b>Services Used:</b></p>
        <ul style="list-style: none;">
            <li>✔ EC2 (Web Server)</li>
            <li>✔ VPC (Networking)</li>
            <li>✔ S3 (Storage)</li>
            <li>✔ CloudWatch (Monitoring)</li>
            <li>✔ IAM (Security)</li>
        </ul>
        <p style="color: green;"><b>Status: Successfully Deployed ✅</b></p>
    </div>
</body>
</html>
HTML

EOF
}