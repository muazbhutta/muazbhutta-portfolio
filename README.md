<div align="center">

# 🖥️ Muaz Bhutta — DevOps Portfolio

**A dark, terminal-themed personal portfolio website for a DevOps Engineer — with a 3D animated hero, typing effects, and a live infrastructure diagram.**

![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![License: MIT](https://img.shields.io/badge/License-MIT-39FF7A?style=for-the-badge)

![Status](https://img.shields.io/badge/status-available__for__hire-39FF7A?style=flat-square&logo=statuspage&logoColor=white)
![Responsive](https://img.shields.io/badge/responsive-yes-00D9FF?style=flat-square&logo=googlechrome&logoColor=white)
![Dark Mode](https://img.shields.io/badge/theme-dark%20%2F%20light-8B5CF6?style=flat-square&logo=darkreader&logoColor=white)
![No Build Step](https://img.shields.io/badge/build%20step-none-success?style=flat-square)

`~$ muaz.bhutta` ▊ &nbsp;·&nbsp; [🌐 GitHub](https://github.com/muazbhutta) &nbsp;·&nbsp; [💼 LinkedIn](https://www.linkedin.com/in/muhammad-muaz-bhutta-5b6006201) &nbsp;·&nbsp; [📧 Email](mailto:muazbhutta599@gmail.com)

</div>

---

## 📌 What This Project Is

This is the personal portfolio website of **Muaz Bhutta**, an Associate DevOps Engineer with 3+ years of experience building, automating, and scaling infrastructure. The site is designed to *look and feel like a terminal* — JetBrains Mono type, a blinking cursor, `$ whoami`-style bio output, and a neon cyan/green/purple palette on a dot-matrix background.

It is a **fully static, zero-build website**: one HTML file, two JavaScript files, no frameworks to install, no bundler, no dependencies to manage. Open it in a browser and it runs.

---

## ✨ What This Project Has

| Feature | Description |
|---|---|
| 🧊 **3D Animated Hero** | Rotating Docker/server cubes, floating Kubernetes hexagons, and animated CI/CD pipeline lines — with mouse-parallax depth layers |
| ⌨️ **Typing Effects** | A looping role typer (`DevOps Engineer`, `CI/CD Pipeline Architect`, …) plus a terminal-style bio that "types itself" when scrolled into view |
| 🧭 **Smart Navigation** | Sticky blurred navbar with scroll-spy (active section highlighting) and a mobile hamburger menu |
| 🛠️ **Tech Stack Grid** | Categorized skill tiles — CI/CD, Containers, Linux, IaC, Monitoring, Cloud & Networking |
| 💼 **Experience Timeline** | Real bullet points from 3 years at GoCloud Pvt Ltd |
| 🚀 **Featured Projects** | Six real DevOps projects (WG-API, OpenVPN dashboard/load balancer, self-hosted DevOps stack, and more) linked to GitHub |
| 🗺️ **Infrastructure Showcase** | An animated diagram of live self-hosted services (GitLab, Jenkins, Gitea, Grafana, …) |
| 📬 **Contact Section** | A form that composes a `mailto:` message — no backend needed — plus social links (GitHub, LinkedIn, Email, WhatsApp) |
| 🌗 **Dark / Light Theme** | Full CSS-variable theming with a light-mode palette |
| 🎨 **Configurable Props** | Accent color, "available for hire" badge, and background grid are toggleable via component props |
| 📄 **Downloadable CV** | One-click CV download served from `uploads/` |
| 📱 **Fully Responsive** | Fluid `clamp()` typography and breakpoint-aware layout down to mobile |

---

## 📁 Directory Structure

```
Muaz Bhutta's DevOps Portfolio/
│
├── index.html          # 💚 The entire site — markup, styles, and component logic
├── support.js          # ⚙️ Runtime that renders the <x-dc> component template (generated — do not edit)
├── image-slot.js       # 🖼️ <image-slot> web component for drag-and-drop image placeholders
│
├── uploads/            # 📦 Static assets
│   ├── MUAZBHUTTA CV.pdf               # CV (multiple versions)
│   ├── MUAZBHUTTA CV-a19ef159.pdf      # ← the version linked by the Download button
│   ├── MUAZBHUTTA CV (third theme).pdf
│   └── *.png / *.jpeg                  # Images used across the site
│
└── README.md           # 📖 You are here
```

---

## ⚙️ How It Works

1. **`index.html`** contains everything: an `<x-dc>` template holding all the markup (nav, hero, about, skills, experience, projects, infrastructure, contact, footer) and a `<script type="text/x-dc">` block holding a `Component` class with the page logic.

2. **`support.js`** is a small generated runtime. On page load it parses the `<x-dc>` template, binds the `{{ placeholders }}`, `sc-if` conditionals, and `sc-for` loops to the component's state, and renders the page reactively — think of it as a tiny, self-contained templating/React-bridge engine.

3. **The `Component` class** drives all the interactivity:
   - `typeLoop()` / `typeBio()` — character-by-character typing animations
   - `setupParallax()` — mouse-tracked 3D transforms on the hero's far/near layers
   - `setupReveal()` — `IntersectionObserver`-based fade-in-on-scroll for each section
   - `setupActiveNav()` — scroll-spy that highlights the section you're viewing
   - `applyAccent()` — writes the chosen accent color into CSS variables at runtime

4. **All data lives in `renderVals()`** — nav links, skill categories, experience bullets, project cards, hosted services, and social links are plain JavaScript arrays, so editing content never requires touching markup.

5. **No backend anywhere.** The contact form builds a `mailto:` URL from the form fields and opens the visitor's own mail client.

---

## 🚀 How to Use This Project

### Run it locally

No installation required — it's pure static files.

**Option 1 — just open it:**
```bash
# Double-click index.html, or:
start index.html        # Windows
open index.html         # macOS
```

**Option 2 — serve it (recommended, so fonts and the CV download behave correctly):**
```bash
# Python
python -m http.server 8000

# or Node
npx serve .
```
Then visit **http://localhost:8000**.

### Make it your own

Want to use this as a template for *your* portfolio? Fork/clone it, then:

1. **Edit your identity** — in `index.html`, update the `roles` array, `bioText`, and the hero name/tagline.
2. **Edit your content** — inside `renderVals()`, replace the `cats` (skills), `expBullets` (experience), `projects`, `services`, and `socials` arrays with your own.
3. **Swap the CV** — drop your PDF into `uploads/` and update the Download CV link's `href`.
4. **Tune the theme** — change the CSS variables at the top of the `<style>` block (`--cyan`, `--green`, `--purple`, `--bg`, …) or use the `accentColor` prop.
5. **Deploy anywhere static** — GitHub Pages, Netlify, Vercel, Cloudflare Pages, or any plain web server. Just upload the folder.

```bash
# Example: deploy to GitHub Pages
git init
git add .
git commit -m "My portfolio"
git branch -M main
git remote add origin https://github.com/<you>/<repo>.git
git push -u origin main
# then enable Pages in the repo settings → deploy from main
```

---

## 📄 License

This project is licensed under the **MIT License**.

```
MIT License

Copyright (c) 2026 Muaz Bhutta

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

> **Note:** personal content (CV, photos in `uploads/`, and biography text) is © Muaz Bhutta and not covered by the MIT license — please replace it with your own if you reuse the template.

---

<div align="center">

**Built with 💚 by [Muaz Bhutta](https://github.com/muazbhutta)** &nbsp;·&nbsp; `$ uptime --career → 3+ years, 0 unplanned outages of motivation`

⭐ If this template helped you, consider giving it a star!

</div>
