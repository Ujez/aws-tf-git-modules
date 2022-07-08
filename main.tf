resource "aws_key_pair" "levelup_key" {
  key_name   = "levelup_key4"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

module "ec2_cluster" {
  source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

  name          = "my-cluster"
  ami           = "ami-0f65ab0fd913bc7be"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0b82885deb904d684"
  key_name      = aws_key_pair.levelup_key.key_name

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


output "public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = try(aws_instance.this[0].public_ip, aws_spot_instance_request.this[0].public_ip, "")
}