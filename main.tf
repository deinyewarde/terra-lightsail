terraform {
	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "~> 4.16"
		}
	}
}

provider "aws" {
	region = var.aws_region
}

resource "aws_lightsail_instance" "lightsail_instance" {
	name = var.instance_name
	availability_zone = "${var.aws_region}a"
	blueprint_id = var.blueprint_id
	bundle_id = var.bundle_id
}

# Create a static public IP address on Lightsail
resource "aws_lightsail_static_ip" "static_ip" {
	name = "${var.instance_name}_staticIP"
}

# Attach static IP address to Lightsail instance
resource "aws_lightsail_static_ip_attachment" "static_ip_attach" {
	static_ip_name = aws_lightsail_static_ip.static_ip.id
	instance_name = aws_lightsail_instance.lightsail_instance.id
}

resource "aws_lightsail_domain" "domain" {
  domain_name = var.domain_name
}

resource "aws_lightsail_domain_entry" "arecord" {
	domain_name = aws_lightsail_domain.domain.domain_name
	type = "A"
	name =""
	target = aws_lightsail_static_ip.static_ip.ip_address
}

resource "aws_lightsail_domain_entry" "wwwrecord" {
	domain_name = aws_lightsail_domain.domain.domain_name
	type = "A"
	name ="www"
	target = aws_lightsail_static_ip.static_ip.ip_address
}
