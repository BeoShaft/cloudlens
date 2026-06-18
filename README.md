# CloudLens

A local [MCP](https://modelcontextprotocol.io) server that gives AI coding agents read-only visibility into your S3 buckets across all configured AWS profiles.

## What it does

CloudLens exposes three tools to MCP-compatible agents (opencode, Claude Code, etc.):

| Tool | Description |
|------|-------------|
| `list_s3_buckets` | List S3 buckets across all configured AWS profiles |
| `get_bucket_config` | Inspect a bucket's region, versioning, encryption, public access block, and policy |
| `whoami` | Show AWS caller identity (account, ARN, user ID) per profile |

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/BeoShaft/cloudlens/main/install.sh | bash
```

Then restart your agent so the MCP server is picked up.

## Manual setup

See [`SKILL.md`](./SKILL.md) for step-by-step instructions if you prefer to install by hand.

## Requirements

- macOS (Apple Silicon or Intel)
- AWS credentials configured in `~/.aws/credentials` or `~/.aws/config`
- An MCP-compatible agent (opencode, Claude Code, etc.)

## License

MIT
