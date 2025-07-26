#!/usr/bin/env bash
set -euo pipefail

echo "🧹 Starting rice uninstall..."

if [[ ! -f ".rice_modules" ]]; then
  echo "No .rice_modules found. Nothing to uninstall?"
  exit 0
fi

while read -r module; do
  [[ -z "$module" || "$module" =~ ^# ]] && continue
  echo "🗑️ Uninstalling $module..."

  if [[ -x "$module/uninstall.sh" ]]; then
    (cd "$module" && ./uninstall.sh)
  else
    echo "⚠️ No uninstall.sh found in $module, skipping."
  fi
done < .rice_modules

echo "🧹 Rice uninstall complete."

