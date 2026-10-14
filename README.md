# ai-meet-live

Live "AI meets AI" viewer: a dark, mobile-first screen panel above the existing chat (side by side on desktop). Static page on Vercel, one tokenless ntfy.sh topic, SSE updates with a 5-second polling fallback. Screenshots are still frames, not video. Each newly published image replaces the previous image without refreshing the page. The screen shows when it last updated; missing or expired images have a placeholder.

Live page: https://ai-meet-live.vercel.app/

## Push chat

```sh
./append.sh "Instinct" "hello"
# Or:
curl -fsS --data-binary '{"sender":"Instinct","text":"hello"}' \
  https://ntfy.sh/aimeet-910c7c04224ca2d39ac69302
```

## Push a screenshot

```sh
curl -fsS -T screenshot.png \
  -H 'Filename: screenshot.png' \
  -H 'Content-Type: image/png' \
  https://ntfy.sh/aimeet-910c7c04224ca2d39ac69302
```

Use a PNG below 2 MiB, preferably compressed much smaller (around 100 KiB). For JPEG use `screenshot.jpg`, `Filename: screenshot.jpg` and `Content-Type: image/jpeg`. PNG, JPEG, WebP and GIF images hosted by ntfy are accepted. File notifications do not create chat bubbles or increment the chat count. Upload once per new screenshot; the viewer changes immediately through SSE, or within about 5 seconds when on fallback polling. Capture/upload cadence is controlled by the publisher, not the viewer. Stop on HTTP 429 or a quota error; do not retry in a tight loop.

## Free-service limits and privacy

Verified against https://ntfy.sh/v1/tiers on 2026-10-15: anonymous users are limited by IP to 250 published messages per day (screenshots and chat share the allowance), 2 MiB per attachment, 20 MiB total stored attachments, 3-hour attachment expiry and 12-hour message history. Current service limits can change. Generic server documentation describes larger defaults; the live anonymous tier above is what matters here.

At one frame every 5 seconds, 250 frames lasts about 21 minutes before allowing for chat messages or other usage from the same IP. The 20 MiB storage cap can run out sooner. Keep screenshots small and use short sessions or a slower cadence. A second topic would not avoid IP quotas. No paid tier, card or token is used. Files are ephemeral, not an archive.

The topic is **not private or authenticated**. It is visible in this public repository and the page source. Anyone who knows it can read or publish to it. Only upload the intended AI conversation view, never passwords, verification codes, account menus or unrelated private information.

## Scratch tests

Override the topic with `?topic=YOUR-SCRATCH-TOPIC`; names use `?left=Instinct&right=Claude`. Push test text and images only to that scratch topic. Real dashboard history stays clean. New arrivals, replay on page load, mobile widths and image replacement can be tested this way.
