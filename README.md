# ATPix Homepage

Static marketing site for [ATPix](https://github.com/peterVG/ATPix), published at [atpix.net](https://atpix.net) via GitHub Pages.

All styles, fonts, and images are **self-hosted** from this repository (no CDN dependencies).

## Contents

```
atpix-homepage/
├── index.html
├── CNAME                 # atpix.net
├── .nojekyll
├── assets/
│   ├── css/
│   │   ├── fonts.css     # @font-face declarations
│   │   └── main.css      # compiled Tailwind (committed)
│   ├── fonts/            # Inter, Hanken Grotesk, JetBrains Mono, Material Symbols
│   └── images/           # homepage photography
├── src/input.css         # Tailwind source
├── tailwind.config.js
├── scripts/vendor-assets.sh
└── package.json
```

## Local preview

```bash
python3 -m http.server 8080
```

Open [http://localhost:8080](http://localhost:8080).

## Rebuild assets

After editing `index.html` classes or `src/input.css`:

```bash
npm install
npm run build:css
```

To re-download fonts and images from upstream sources:

```bash
npm run vendor:assets
```

Commit `assets/css/main.css` (and any updated font/image files) before pushing.

## GitHub Pages

1. **Settings → Pages → Source:** branch `main`, folder `/ (root)`
2. **Custom domain:** `atpix.net`
3. GoDaddy DNS: four `A` records on `@` pointing to GitHub Pages IPs ([GitHub docs](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site))