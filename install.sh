#!/usr/bin/env bash
# CloudLens installer — downloads the MCP server binary + skill and registers it with opencode.
set -euo pipefail

REPO="BeoShaft/cloudlens"
INSTALL_DIR="$HOME/.local/bin"
SKILL_DIR="$HOME/.config/opencode/skills/cloudlens"
BINARY="$INSTALL_DIR/cloudlens"

echo "CloudLens installer"
echo "===================="
echo ""

# Detect architecture
ARCH="$(uname -m)"
case "$ARCH" in
  arm64|aarch64) ASSET="cloudlens-darwin-arm64" ;;
  x86_64|amd64)  ASSET="cloudlens-darwin-amd64" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac
echo "Detected: darwin/$ARCH"

# Download binary
mkdir -p "$INSTALL_DIR"
URL="https://github.com/$REPO/releases/latest/download/$ASSET"
echo "Downloading: $URL"
curl -fsSL -o "$BINARY" "$URL"
chmod +x "$BINARY"
echo "Installed:   $BINARY"

# Download skill
mkdir -p "$SKILL_DIR"
curl -fsSL -o "$SKILL_DIR/SKILL.md" "https://raw.githubusercontent.com/$REPO/main/SKILL.md"
echo "Skill:       $SKILL_DIR/SKILL.md"

# Register MCP server in opencode config
CONFIG="$HOME/.config/opencode/opencode.json"
mkdir -p "$(dirname "$CONFIG")"

if command -v python3 >/dev/null 2>&1; then
  python3 - "$CONFIG" "$BINARY" <<'PY'
import json, os, sys
cfg_path, binary = sys.argv[1], sys.argv[2]
try:
    with open(cfg_path) as f:
        cfg = json.load(f)
except (FileNotFoundError, json.JSONDecodeError):
    cfg = {}
cfg.setdefault("$schema", "https://opencode.ai/config.json")
cfg.setdefault("mcp", {})
cfg["mcp"]["cloudlens"] = {"type": "local", "command": [binary], "enabled": True}
os.makedirs(os.path.dirname(cfg_path), exist_ok=True)
with open(cfg_path, "w") as f:
    json.dump(cfg, f, indent=2)
    f.write("\n")
print(f"Registered:  {cfg_path}")
PY
else
  echo ""
  echo "python3 not found. Add this to $CONFIG manually:"
  echo "  \"mcp\": { \"cloudlens\": { \"type\": \"local\", \"command\": [\"$BINARY\"], \"enabled\": true } }"
fi

echo ""
echo "Done. Restart opencode to load CloudLens."
