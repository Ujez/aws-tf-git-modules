module "ec2_cluster" {
    source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

    name    = "my-cluster"
    ami     = "ami-0f65ab0fd913bc7be"
    instance_type          = "t2.micro"
    subnet_id   = "subnet-0b82885deb904d684"

    tags = {
    Terraform   = "true"
    Environment = "dev"
    }
}