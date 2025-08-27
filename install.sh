#!/usr/bin/env bash
set -euo pipefail

echo "🛠️ Starting selective rice install..."

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$ROOT_DIR/path-vars.sh"

cd $ROOT_DIR
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
done < $M_PATH
cd $TEMP_DIR

echo "✅ Selective rice installation done."

