#!/usr/bin/env bash
# Install one or all ai-skills into a target project's .claude/ directory.
#
# Usage:
#   Install a single skill:
#     ./install.sh <skill-name> [target-dir]
#
#   Install all skills:
#     ./install.sh --all [target-dir]
#
#   Via curl (replace <VERSION> with a tag or "main"):
#     curl -fsSL https://raw.githubusercontent.com/maverick-nk/ai-skills/<VERSION>/install.sh \
#       | bash -s -- <skill-name>
#
# Arguments:
#   skill-name   Name of the skill folder under .claude/ (e.g. adr, concept-quiz)
#   target-dir   Directory to install into (default: current working directory)

set -euo pipefail

REPO_URL="https://github.com/maverick-nk/ai-skills"
RAW_URL="https://raw.githubusercontent.com/maverick-nk/ai-skills/main"
SKILLS=(adr concept-quiz repo-context-system)

usage() {
  echo "Usage: $0 <skill-name|--all> [target-dir]"
  echo ""
  echo "Available skills: ${SKILLS[*]}"
  exit 1
}

install_skill() {
  local skill="$1"
  local target_dir="$2"
  local dest="${target_dir}/.claude/${skill}"

  echo "Installing skill: ${skill} → ${dest}"
  mkdir -p "$dest"

  # If running from a local clone, copy directly
  local script_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  if [[ -f "${script_dir}/.claude/${skill}/SKILL.md" ]]; then
    cp "${script_dir}/.claude/${skill}/SKILL.md" "${dest}/SKILL.md"
  else
    # Fetch from GitHub
    curl -fsSL "${RAW_URL}/.claude/${skill}/SKILL.md" -o "${dest}/SKILL.md"
  fi

  echo "  ✓ ${dest}/SKILL.md"
}

main() {
  [[ $# -lt 1 ]] && usage

  local skill="$1"
  local target_dir="${2:-.}"

  if [[ "$skill" == "--all" ]]; then
    for s in "${SKILLS[@]}"; do
      install_skill "$s" "$target_dir"
    done
  else
    # Validate skill name
    local valid=false
    for s in "${SKILLS[@]}"; do
      [[ "$s" == "$skill" ]] && valid=true && break
    done
    if [[ "$valid" == false ]]; then
      echo "Unknown skill: ${skill}"
      echo "Available: ${SKILLS[*]}"
      exit 1
    fi
    install_skill "$skill" "$target_dir"
  fi

  echo ""
  echo "Done. Skills are active on next Claude Code session in ${target_dir}"
}

main "$@"
