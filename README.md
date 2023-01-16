# Infrastructure as Code

I prefer to use [Terraform][tf] to manage as much of my infrastructure as possible. After pushing commits to the `main` branch, [Terraform Cloud][tf-cloud] will automatically apply the changes.

## Cloudflare API token

The following permissions are required for the [Cloudflare provider][cf-provider] to function properly:

- Account.Account Settings:Read
- Account.Cloudflare Pages:Edit
- Account.Cloudflare Tunnel:Edit
- Zone.Zone:Edit
- Zone.Zone Settings:Edit
- Zone.Page Rules:Edit
- Zone.DNS:Edit
- Zone.Workers Routes:Edit

## Cloudflare API token for GitHub Actions

The following permissions are required for the [GitHub Actions][gh-actions] to deploy Cloudflare Workers:

- Account.Cloudflare Pages:Edit
- Account.Workers Scripts:Edit

## GitHub PAT

The [GitHub provider][gh-provider] requires a [fine-grained personal access token][gh-pat] with access to **all repositories** and the following permissions:

- Administration: Read and write
- Contents: Read and write
- Metadata: Read-only
- Secrets: Read and write

[tf]: https://www.terraform.io/
[tf-cloud]: https://www.terraform.io/cloud
[cf-provider]: https://registry.terraform.io/providers/cloudflare/cloudflare/latest
[gh-actions]: https://docs.github.com/en/actions
[gh-provider]: https://registry.terraform.io/providers/integrations/github/latest
[gh-pat]: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token#creating-a-fine-grained-personal-access-token