# CloudLens

A local [MCP](https://modelcontextprotocol.io) server that gives AI coding agents read-only visibility into your S3 buckets across all configured AWS profiles.

## Install via Claude Code marketplace

```bash
claude plugin marketplace add BeoShaft/cloudlens
claude plugin install cloudlens@cloudlens
```

Restart Claude Code, then ask: "List all my S3 buckets."

## Tools

| Tool | Description |
|------|-------------|
| `list_s3_buckets` | List S3 buckets across all configured AWS profiles |
| `get_bucket_config` | Inspect a bucket's region, versioning, encryption, public access block, and policy |
| `whoami` | Show AWS caller identity (account, ARN, user ID) per profile |

## Requirements

- macOS (Apple Silicon or Intel) or Linux (amd64/arm64)
- AWS credentials configured in `~/.aws/credentials` or `~/.aws/config`
- Claude Code

## License

MIT
