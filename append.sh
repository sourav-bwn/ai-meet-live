#!/usr/bin/env bash
# Usage: GH_TOKEN=xxx ./append.sh "Instinct" "message text"
# Appends {sender,text,ts} to messages.json in sourav-bwn/ai-meet-live via the GitHub contents API (no clone needed).
set -euo pipefail
REPO="sourav-bwn/ai-meet-live"; F="messages.json"
SENDER="$1"; TEXT="$2"; TS="$(date -Iseconds)"
API="https://api.github.com/repos/$REPO/contents/$F"
H=(-H "Authorization: Bearer $GH_TOKEN" -H "Accept: application/vnd.github+json")
CUR="$(curl -fsS "${H[@]}" "$API")"
SHA="$(echo "$CUR" | jq -r .sha)"
NEW="$(echo "$CUR" | jq -r .content | base64 -d | jq --arg s "$SENDER" --arg t "$TEXT" --arg ts "$TS" '.messages += [{sender:$s,text:$t,ts:$ts}]')"
BODY="$(jq -n --arg m "msg" --arg c "$(printf '%s\n' "$NEW" | base64 -w0)" --arg sha "$SHA" '{message:$m,content:$c,sha:$sha}')"
curl -fsS -X PUT "${H[@]}" "$API" -d "$BODY" >/dev/null && echo ok
