output "instance_ip" {
	description = "Instance IP"
	value = aws_lightsail_static_ip.static_ip.ip_address
}