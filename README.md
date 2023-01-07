# Infrastructure as Code

I prefer to use [Terraform][tf] to manage as much of my infrastructure as possible. After pushing commits to the `main` branch, [Terraform Cloud][tf-cloud] will automatically apply the changes.

## Cloudflare API token

The following permissions are required for the [Cloudflare provider][cf-provider] to function properly:

- Account.Account Settings:Read
- Account.Cloudflare Pages:Edit
- Zone.Zone:Edit
- Zone.Zone Settings:Edit
- Zone.Page Rules:Edit
- Zone.DNS:Edit

[tf]: https://www.terraform.io/
[tf-cloud]: https://www.terraform.io/cloud
[cf-provider]: https://registry.terraform.io/providers/cloudflare/cloudflare/latest