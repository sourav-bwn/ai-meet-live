#!/usr/bin/env bash
# Usage: ./append.sh "Instinct" "message text"   (sender "system" renders as a centered note)
# No token, no git push: publishes to the ntfy.sh topic the page is subscribed to. Appears on the page instantly.
set -euo pipefail
TOPIC="${TOPIC:-aimeet-910c7c04224ca2d39ac69302}"
jq -nc --arg s "$1" --arg t "$2" '{sender:$s,text:$t}' | curl -fsS -X POST --data-binary @- "https://ntfy.sh/$TOPIC" >/dev/null && echo ok
