#!/usr/bin/env bash

TMP_DIR=$(pwd)
M_FILE=".rice_modules"
M_PATH="$ROOT_DIR/$M_FILE"

if [[ ! -f $M_PATH ]]; then
  echo "No $M_PATH file found! Create one listing submodules to install."
  exit 1
fi
