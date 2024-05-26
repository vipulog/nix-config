#!/usr/bin/env bash

export USER_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/whatsapp-web-data"

brave --app="https://web.whatsapp.com" \
  --user-data-dir="$USER_DATA_DIR" \
  --class="com.whatsapp.web" \
  --disable-features="TranslateUI" \
  --no-first-run
