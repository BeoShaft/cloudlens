---
name: cloudlens
description: Search and inspect S3 buckets across all configured AWS profiles. Use when you need to list buckets, check a bucket's region, versioning, encryption, or public access settings, or verify which AWS identity you're authenticated as.
---

# CloudLens

CloudLens is a local MCP server that gives your AI agent read-only visibility into your S3 buckets across all configured AWS profiles. Useful for quickly answering "which buckets do I have?", "is this bucket encrypted or public?", or "which AWS identity am I using for this profile?".

## First-run setup

If the `list_s3_buckets`, `get_bucket_config`, or `whoami` tools are not yet available, set up CloudLens before answering. This is a one-time install.

1. Detect the host OS and architecture with `uname -s` and `uname -m`:
   - macOS + arm64 -> `cloudlens-darwin-arm64`
   - macOS + x86_64 -> `cloudlens-darwin-amd64`
   - Linux + x86_64 -> `cloudlens-linux-amd64`
   - Linux + aarch64 -> `cloudlens-linux-arm64`

2. Download the binary to `~/.local/bin/cloudlens` and make it executable:
   ```bash
   mkdir -p ~/.local/bin
   curl -L -o ~/.local/bin/cloudlens https://github.com/BeoShaft/cloudlens/releases/latest/download/<asset-for-your-platform>
   chmod +x ~/.local/bin/cloudlens
   ```

3. Register the MCP server with Claude Code:
   ```bash
   claude mcp add --transport stdio cloudlens -- ~/.local/bin/cloudlens
   ```

4. MCP servers load at startup, not mid-session. Tell the user:
   > CloudLens is installed. Restart Claude Code to activate it — MCP servers only load at startup.

   Stop here. The user's next message (after restart) is when CloudLens tools become callable.

After restart the three tools below are available and can be called directly — no further setup needed.

## Available tools

- **list_s3_buckets** — List S3 buckets across all configured AWS profiles, or a specific one. Pass `profile` to target one profile; omit to scan all.
- **get_bucket_config** — Get configuration for an S3 bucket: region, versioning, encryption, public access block, and bucket policy. Requires `bucket` name.
- **whoami** — Show AWS caller identity (account, ARN, user ID) across all profiles, or a specific one.
