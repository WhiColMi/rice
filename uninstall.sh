#!/usr/bin/env bash
set -euo pipefail

echo "🧹 Starting rice uninstall..."

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$ROOT_DIR/path-vars.sh"

cd $ROOT_DIR
while read -r module; do
  [[ -z "$module" || "$module" =~ ^# ]] && continue
  echo "🗑️ Uninstalling $module..."

  if [[ -x "$module/uninstall.sh" ]]; then
    (cd "$module" && ./uninstall.sh)
  else
    echo "⚠️ No uninstall.sh found in $module, skipping."
  fi
done < $M_PATH
cd $TMP_DIR

echo "🧹 Rice uninstall complete."

