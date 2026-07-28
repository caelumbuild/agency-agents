#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE_DIR="$REPO_ROOT/caelumbuild"
TOOL="claude-code"
DEST=""
DRY_RUN=false

usage() {
  cat <<'EOF'
Install the focused Caelum Build agent team.

Usage:
  ./scripts/install-caelumbuild.sh [--tool claude-code|codex|cursor|opencode] [--path DIR] [--dry-run]

Defaults:
  claude-code -> ~/.claude/agents
  codex       -> ~/.codex/agents
  cursor      -> .cursor/rules
  opencode    -> .opencode/agents
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tool) TOOL="${2:?missing tool}"; shift 2 ;;
    --path) DEST="${2:?missing path}"; shift 2 ;;
    --dry-run) DRY_RUN=true; shift ;;
    --help|-h) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 2 ;;
  esac
done

if [[ -z "$DEST" ]]; then
  case "$TOOL" in
    claude-code) DEST="${CLAUDE_CONFIG_DIR:-$HOME/.claude/agents}" ;;
    codex) DEST="${CODEX_AGENTS_DIR:-$HOME/.codex/agents}" ;;
    cursor) DEST="${CURSOR_RULES_DIR:-$PWD/.cursor/rules}" ;;
    opencode) DEST="${OPENCODE_AGENTS_DIR:-$PWD/.opencode/agents}" ;;
    *) echo "Unsupported tool: $TOOL" >&2; exit 2 ;;
  esac
fi

mapfile -t FILES < <(find "$SOURCE_DIR" -maxdepth 1 -type f -name '*.md' | sort)
[[ ${#FILES[@]} -gt 0 ]] || { echo "No Caelum Build agents found." >&2; exit 1; }

echo "Caelum Build agents: ${#FILES[@]}"
echo "Destination: $DEST"

if $DRY_RUN; then
  printf 'Would install: %s\n' "${FILES[@]}"
  exit 0
fi

mkdir -p "$DEST"
for file in "${FILES[@]}"; do
  cp "$file" "$DEST/$(basename "$file")"
done

echo "Installed ${#FILES[@]} Caelum Build agents for $TOOL."
