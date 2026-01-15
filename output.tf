output "hub_vpn_server_public_ip" {
  description = "Public IP of the Hub VPN Server"
  value       = aws_instance.hub_vpn_server.public_ip
}

output "spoke_a_app_private_ip" {
  description = "Private IP of Spoke A Application Server"
  value       = aws_instance.spoke_a_app.private_ip
}

output "spoke_b_app_private_ip" {
  description = "Private IP of Spoke B Application Server"
  value       = aws_instance.spoke_b_app.private_ip
}