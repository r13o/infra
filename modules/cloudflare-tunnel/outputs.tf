output "credentials" {
  value = <<EOT
{
  "AccountTag": "${var.account_id}",
  "TunnelID": "${cloudflare_argo_tunnel.tunnel.id}",
  "TunnelName": "${cloudflare_argo_tunnel.tunnel.name}",
  "TunnelSecret": "${sensitive(random_id.tunnel_secret.b64_std)}"
}
EOT
}
