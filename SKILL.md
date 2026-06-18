---
name: cloudlens
description: Search and inspect S3 buckets across all configured AWS profiles. Use when you need to list buckets, check a bucket's region, versioning, encryption, or public access settings, or verify which AWS identity you're authenticated as.
---

# CloudLens

CloudLens is a local MCP server that gives your AI agent read-only visibility into your S3 buckets across all configured AWS profiles. Useful for quickly answering "which buckets do I have?", "is this bucket encrypted or public?", or "which AWS identity am I using for this profile?".

## Setup (run once)

Before CloudLens tools are available the MCP server binary must be downloaded and registered with your agent. Perform these steps:

1. Detect the host macOS architecture:
   - Apple Silicon -> `arm64`
   - Intel -> `amd64`

2. Download the binary for the detected architecture from the latest release:
   - arm64: `https://github.com/BeoShaft/cloudlens/releases/latest/download/cloudlens-darwin-arm64`
   - amd64: `https://github.com/BeoShaft/cloudlens/releases/latest/download/cloudlens-darwin-amd64`

3. Save the binary to `~/.local/bin/cloudlens` and make it executable:
   ```bash
   mkdir -p ~/.local/bin
   curl -L -o ~/.local/bin/cloudlens <url-for-your-architecture>
   chmod +x ~/.local/bin/cloudlens
   ```

4. Register the MCP server in the opencode config. Add (or merge) this block into `opencode.json` — use the **absolute path** to the binary (expand `~` to the home directory):
   ```json
   {
     "mcp": {
       "cloudlens": {
         "type": "local",
         "command": ["/Users/your-username/.local/bin/cloudlens"],
         "enabled": true
       }
     }
   }
   ```
   Place it in `~/.config/opencode/opencode.json` (global) or the project's `opencode.json`.

5. Restart opencode so the MCP server is loaded. The CloudLens tools will then be available.

Alternatively, run the one-shot installer which performs all of the above automatically:
```bash
curl -fsSL https://raw.githubusercontent.com/BeoShaft/cloudlens/main/install.sh | bash
```

## Available tools

- **list_s3_buckets** — List S3 buckets across all configured AWS profiles, or a specific one. Pass `profile` to target one profile; omit to scan all.
- **get_bucket_config** — Get configuration for an S3 bucket: region, versioning, encryption, public access block, and bucket policy. Requires `bucket` name.
- **whoami** — Show AWS caller identity (account, ARN, user ID) across all profiles, or a specific one.

## Usage examples

Ask the agent things like:
- "List all my S3 buckets"
- "Check the encryption and public access config for the production-data bucket"
- "Which AWS identity am I using for the dev profile?"
