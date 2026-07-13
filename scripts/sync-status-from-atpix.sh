#!/usr/bin/env bash
# Print homepage status suggestions from ATPix docs/overview/005-plan.md.
set -euo pipefail

ATPIX_REPO="${1:-${ATPIX_REPO:-../ATPix}}"
PLAN_FILE="${ATPIX_REPO}/docs/overview/005-plan.md"

if [[ ! -f "${PLAN_FILE}" ]]; then
  echo "ERROR: Plan file not found: ${PLAN_FILE}" >&2
  echo "Usage: $0 [path-to-ATPix-clone]" >&2
  echo "Or set ATPix_REPO=/path/to/ATPix" >&2
  exit 1
fi

echo "ATPix plan: ${PLAN_FILE}"
echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo ""

CURRENT_STATE="$(grep -m1 '^\*\*Current state:\*\*' "${PLAN_FILE}" | sed 's/^\*\*Current state:\*\* //')"
if [[ -n "${CURRENT_STATE}" ]]; then
  echo "=== Current state (from plan) ==="
  echo "${CURRENT_STATE}"
  echo ""
fi

DONE_TASKS=()
OPEN_TASKS=()

while IFS= read -r line; do
  if echo "${line}" | grep -q '^- \[x\]'; then
    title="$(echo "${line}" | sed -E 's/^- \[[xX]\] \*\*Task [^:]+: //; s/\*\*$//')"
    DONE_TASKS+=("${title}")
  elif echo "${line}" | grep -q '^- \[ \]'; then
    title="$(echo "${line}" | sed -E 's/^- \[ \] \*\*Task [^:]+: //; s/\*\*$//')"
    OPEN_TASKS+=("${title}")
  fi
done < <(grep -E '^- \[[ xX]\] \*\*Task' "${PLAN_FILE}")

echo "=== Shipped tasks (${#DONE_TASKS[@]} checked in plan) ==="
for title in "${DONE_TASKS[@]}"; do
  echo "  • ${title}"
done
echo ""

echo "=== Open tasks (${#OPEN_TASKS[@]} remaining) ==="
for title in "${OPEN_TASKS[@]}"; do
  echo "  • ${title}"
done
echo ""

if [[ ${#OPEN_TASKS[@]} -gt 0 ]]; then
  echo "=== Suggested homepage: In Progress ==="
  echo "  • ${OPEN_TASKS[0]}"
  for title in "${OPEN_TASKS[@]}"; do
    if echo "${title}" | grep -qi 'permissioned'; then
      if [[ "${title}" != "${OPEN_TASKS[0]}" ]]; then
        echo "  • ${title} (mandatory v1 R&D)"
      fi
      break
    fi
  done
  echo ""
fi

if [[ ${#OPEN_TASKS[@]} -gt 1 ]]; then
  echo "=== Suggested homepage: Planned (condense for marketing) ==="
  idx=0
  for title in "${OPEN_TASKS[@]}"; do
    if [[ ${idx} -gt 0 ]]; then
      echo "  • ${title}"
    fi
    idx=$((idx + 1))
  done
  echo ""
fi

LAST_DONE_ID="$(grep -E '^- \[[xX]\] \*\*Task' "${PLAN_FILE}" | tail -1 | sed -E 's/^- \[[xX]\] \*\*Task ([0-9]+)\.[0-9]+.*/\1/')"
NEXT_OPEN_ID="$(grep -m1 -E '^- \[ \] \*\*Task' "${PLAN_FILE}" | sed -E 's/^- \[ \] \*\*Task ([0-9]+)\.[0-9]+.*/\1/')"
echo "=== Suggested hero badge ==="
if [[ -n "${NEXT_OPEN_ID}" ]]; then
  echo "  Proof of Concept · Phase ${NEXT_OPEN_ID}"
else
  echo "  Proof of Concept · v1 complete"
fi
if [[ "${LAST_DONE_ID}" == "3" && "${NEXT_OPEN_ID}" == "3" ]]; then
  echo "  (Path A detail: Phase 3 (Path A) while Task 3.x is active)"
fi
echo ""

echo "=== Suggested sync footer line ==="
TODAY="$(date -u +%Y-%m-%d)"
LAST_SHIPPED="$(grep -E '^- \[[xX]\] \*\*Task' "${PLAN_FILE}" | tail -1 | sed -E 's/^- \[[xX]\] \*\*(Task [0-9]+\.[0-9]+:[^*]+)\*\*.*/\1/')"
echo "  Last synced with ATPix main · ${TODAY} (${LAST_SHIPPED} complete)"
echo ""

echo "=== Next steps ==="
echo "  1. Edit index.html (#status section and hero badge)"
echo "  2. See docs/status-sync.md for the full checklist"
echo "  3. git commit -m \"docs: sync homepage status with ATPix main after ...\""