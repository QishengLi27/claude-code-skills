#!/bin/bash
# install.sh — Deploy skills from this repo to ~/.claude/skills/
# Usage: ./install.sh          (install all)
#        ./install.sh <name>   (install one)

set -e
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_HOME="${HOME}/.claude/skills"

echo "Installing skills from ${REPO_DIR}/skills/ → ${SKILLS_HOME}/"

install_one() {
    local name="$1"
    local src="${REPO_DIR}/skills/${name}"
    local dst="${SKILLS_HOME}/${name}"

    if [ ! -d "$src" ]; then
        echo "  ✗ Skill '${name}' not found in repo"
        return 1
    fi

    # Remove existing if it's a symlink or directory
    if [ -L "$dst" ] || [ -d "$dst" ]; then
        rm -rf "$dst"
    fi

    # Create symlink
    ln -s "$src" "$dst"
    echo "  ✓ ${name} → ${dst}"
}

if [ $# -gt 0 ]; then
    # Install specific skill
    install_one "$1"
else
    # Install all skills
    mkdir -p "$SKILLS_HOME"
    for skill_dir in "${REPO_DIR}"/skills/*/; do
        name=$(basename "$skill_dir")
        install_one "$name"
    done
fi

echo ""
echo "Done. Restart Claude Code to load new skills."
echo "Available skills:"
ls -1 "${SKILLS_HOME}" | while read s; do echo "  /${s}"; done
