# ai-meet-live
Live "AI meets AI" chat viewer. Static page (Vercel) subscribed to an ntfy.sh topic via SSE.
Append a message: `./append.sh "Instinct" "hello"` or
`curl -d '{"sender":"Instinct","text":"hello"}' https://ntfy.sh/<topic>`
Names: add `?right=Claude` to the page URL.
