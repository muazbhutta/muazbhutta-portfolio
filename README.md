# Muaz Bhutta — Portfolio

A static portfolio site. No build step, no framework — just HTML/CSS/JS,
so it's easy to maintain. All content lives in one file, `data.js`.

## Features

- Fully static, zero dependencies beyond Google Fonts
- **Light / Dark / Auto** theme toggle (Auto follows the visitor's system
  setting and updates live if it changes)
- Scroll-reveal career timeline, responsive down to mobile
- Auto-deploys to your VPS on every push via GitHub Actions

## File structure

```
portfolio/
├── index.html                     → page structure
├── style.css                      → design & theme tokens
├── script.js                      → renders data.js into the page (no need to edit)
├── data.js                        → *** EDIT THIS FILE to add content ***
└── .github/workflows/deploy.yml   → auto-deploy pipeline
```

## Updating content (the important part)

To add a new project, open `data.js` and add an object like this to the
`PROJECTS` array:

```js
{
  id: "unique-id",
  title: "Project Name",
  summary: "1–2 line description.",
  stack: ["Tech1", "Tech2"],
  link: "https://...", // or "#" if there's no link
  status: "production", // "production" or "lab"
},
```

Skills, credentials, the About paragraphs, and the career timeline all
work the same way — add or edit an object in the matching array. Nothing
in `index.html`, `style.css`, or `script.js` needs to change.

---

## Step 1 — Run it locally

These are static files, so "running" it just means opening it in a
browser. Two options:

**Option A (simplest):** double-click `index.html` and it opens in your
browser.

**Option B (better — avoids relative-path/fetch quirks):** from inside
the folder:

```bash
python3 -m http.server 8000
```

Then open `http://localhost:8000`. This is better because it mirrors how
the file is served on the VPS, so local behavior matches production.

---

## Step 2 — Push to GitHub

```bash
cd portfolio
git init
git add .
git commit -m "Initial portfolio"
git branch -M main
git remote add origin https://github.com/yourusername/portfolio.git
git push -u origin main
```

This matters for two reasons:
1. Your code becomes version-controlled — changes are tracked.
2. It becomes the source for the GitHub Actions pipeline — every push to
   `main` triggers an automatic deploy.

---

## Step 3 — Manual deploy to the VPS (first time, or without CI/CD)

Since the VPS is already running Caddy serving `muazbhutta.online`, you
just need to copy the files into the directory Caddy points at.

```bash
# from your local machine
rsync -avz --delete ./portfolio/ user@your-server-ip:/var/www/portfolio/
```

(Replace `/var/www/portfolio/` with whatever path is set after `root *`
in your Caddyfile.)

If you want the portfolio served at the root domain
(`muazbhutta.online`) rather than a subdomain, confirm your Caddyfile
looks like:

```
muazbhutta.online {
    root * /var/www/portfolio
    file_server
}
```

Then:

```bash
sudo systemctl reload caddy
```

`https://muazbhutta.online` is now live.

**For a subdomain instead** (e.g. `portfolio.muazbhutta.online`), add a
new block in the Caddyfile with the same settings, using the subdomain
in place of the root domain.

---

## Step 4 — CI/CD: auto-deploy on every push

`.github/workflows/deploy.yml` (place it at
`.github/workflows/deploy.yml` in your repo) uses GitHub Actions to copy
files to the VPS over SSH via `rsync` every time you push to `main`.

To make this work, add **4 secrets** to your GitHub repo:

1. Repo → **Settings → Secrets and variables → Actions → New repository
   secret**
2. Add these secrets:

| Secret name       | Value                                            |
|--------------------|---------------------------------------------------|
| `DEPLOY_HOST`      | Your VPS IP address                                |
| `DEPLOY_USER`      | SSH username on the VPS (e.g. `root` or your user) |
| `DEPLOY_PORT`      | `22` (or your custom SSH port)                     |
| `DEPLOY_PATH`      | `/var/www/portfolio/`                              |
| `DEPLOY_SSH_KEY`   | Private SSH key (see below)                        |

### Generating a deploy key (a dedicated key is best practice)

On your local machine:

```bash
ssh-keygen -t ed25519 -C "github-deploy" -f ./deploy_key -N ""
```

This creates `deploy_key` (private) and `deploy_key.pub` (public).

Authorize the public key on the VPS:

```bash
ssh-copy-id -i deploy_key.pub user@your-server-ip
```

(or manually paste the contents of `deploy_key.pub` into
`~/.ssh/authorized_keys` on the VPS)

Then copy the **full contents** of `deploy_key` (the private key) into
the `DEPLOY_SSH_KEY` secret on GitHub.

### Testing it

Make a small change (e.g. add a new project in `data.js`), then:

```bash
git add .
git commit -m "Add new project"
git push
```

Check the **Actions** tab in your GitHub repo — the pipeline runs, and
within 30–60 seconds the new content is live at `muazbhutta.online`. No
manual `rsync` or `ssh` needed.

---

## Full flow, recap

```
Edit data.js (add a project/skill/etc.)
        ↓
git add . && git commit -m "update" && git push
        ↓
GitHub Actions runs rsync to the VPS
        ↓
Caddy is already running → site is live instantly
```

From now on, just edit `data.js` and push — everything else happens
automatically.
