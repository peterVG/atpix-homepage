# ATPix Homepage

Static marketing site for [ATPix](https://github.com/peterVG/ATPix), published at [atpix.net](https://atpix.net) via GitHub Pages.

## Contents

- `index.html` — single-page homepage (Tailwind CDN, Google Fonts, inline styles)
- `CNAME` — custom domain for GitHub Pages
- `.nojekyll` — serve static files without Jekyll processing

## Local preview

```bash
python3 -m http.server 8080
```

Open [http://localhost:8080](http://localhost:8080).

## GitHub Pages

1. **Settings → Pages → Source:** branch `main`, folder `/ (root)`
2. **Custom domain:** `atpix.net`
3. GoDaddy DNS: four `A` records on `@` pointing to GitHub Pages IPs (see [GitHub docs](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site))