# Homepage status sync

Keep [atpix.net](https://atpix.net) (`index.html` **#status** section) aligned with the ATPix monorepo after each milestone merge to `main`.

**Source of truth:** [ATPix `docs/overview/005-plan.md`](https://github.com/peterVG/ATPix/blob/main/docs/overview/005-plan.md) (`Current state` paragraph + task checkboxes).

**Homepage target:** `index.html` → `#status` (hero badge, intro copy, three status columns, “Last synced” line).

---

## Quick workflow

1. Pull latest ATPix `main` and this repo `main`.
2. Run the status helper (from repo root):

   ```bash
   npm run sync:status
   # or: ./scripts/sync-status-from-atpix.sh ../ATPix
   ```

3. Copy or paraphrase the **Suggested homepage copy** into `index.html` (do not paste raw task IDs unless useful for dev audiences).
4. Update the hero badge if the active phase changed (e.g. `Proof of Concept · Phase 3 (Path A)`).
5. Set **Last synced** to today’s date (RFC 3339 calendar date) and note the milestone (e.g. `Task 3.2 merged`).
6. Commit and push `main` on **atpix-homepage** (GitHub Pages deploys automatically).

```bash
git add index.html
git commit -m "docs: sync homepage status with ATPix main after Task X.Y"
git push origin main
```

---

## Column mapping

| Homepage column | Plan signal |
|-----------------|---------------|
| **Shipped** | Tasks marked `[x]` in `005-plan.md`, summarized for a non-developer audience |
| **In Progress** | The next unchecked task(s) on the critical path (usually the first `[ ]` plus the mandatory v1 R&D item if different) |
| **Planned** | Remaining `[ ]` tasks, grouped by theme (Path B discovery, public sharing, C2PA validation UI, performance) |

**Do not overstate shipped work.** Examples:

- “My Gallery (Path A)” is shipped after Task 3.2; “public profile galleries” are not (Task 4.2).
- Lexicons are provisioned (Task 1.2); “production Lexicon publication” as a *next* item is misleading.
- Path B discovery (Task 4.1) is **planned** until permissioned spaces (Task 5.1) validate F-008.

---

## Manual checklist

- [ ] `npm run sync:status` run against an up-to-date ATPix clone
- [ ] `#status` intro paragraph matches `Current state` in the plan
- [ ] Shipped / In Progress / Planned columns are accurate (no false “done” claims)
- [ ] HappyView Discovery bento notes **planned** until Path B ships
- [ ] Links: [docs.atpix.net](https://docs.atpix.net), [implementation plan](https://docs.atpix.net#overview/005-plan.md), [architecture](https://docs.atpix.net#overview/000-architecture.md)
- [ ] “Last synced” date and milestone updated
- [ ] Optional: run `python3 -m http.server 8080` and spot-check locally

---

## Environment

| Variable | Default | Purpose |
|----------|---------|---------|
| `ATPIX_REPO` | `../ATPix` | Path to a local ATPix clone |

The helper reads only `docs/overview/005-plan.md`; it does not modify ATPix or `index.html`.

---

## Related docs

- [ATPix implementation plan](https://github.com/peterVG/ATPix/blob/main/docs/overview/005-plan.md)
- [ATPix README — atpix.net hosting](https://github.com/peterVG/ATPix/blob/main/README.md#step-1--github-pages-atpixnet-homepage)
- [Homepage README](../README.md)