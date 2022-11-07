variable "aws_region" {
	type		= string
	default 	= "eu-west-1"

}

variable "instance_name" {
	description	= "The name of the instance"
	type 		= string
}

variable "bundle_id" {
	type 		= string
	default 	= "nano_2_0"
	description = "The lightsail instance size option"
}

variable "blueprint_id" {
	type 		= string
	default 	= "wordpress"
}

variable "domain_name" {
	type 		= string
}