#!/usr/bin/env bash
set -euo pipefail

echo "🛠️ Starting selective rice install..."

if [[ ! -f ".rice_modules" ]]; then
  echo "No .rice_modules file found! Create one listing submodules to install."
  exit 1
fi

while read -r module; do
  [[ -z "$module" || "$module" =~ ^# ]] && continue  # skip empty lines and comments
  echo "⬇️ Initializing submodule $module..."
  git submodule update --init "$module"
  echo "🔧 Installing $module..."
  if [[ -x "$module/install.sh" ]]; then
    (cd "$module" && ./install.sh)
  else
    echo "⚠️ No install.sh found in $module"
  fi
done < .rice_modules

echo "✅ Selective rice installation done."

