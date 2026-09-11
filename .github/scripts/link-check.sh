#!/usr/bin/env bash
# Link-rot + staleness check for the entry list.
# Verifies every entry repo is reachable; flags archived and >12-month-stale repos.
# Runs locally (macOS/Linux) and in CI. Uses only `gh` (no jq/curl dependency).
# Exits nonzero only when a dead link exists — archived/stale are review hints.
set -uo pipefail

README="${1:-README.md}"
today=$(date -u +%F)

# 12-month cutoff as YYYY-MM-DD (ISO dates sort lexically == chronologically).
if date -u -d '12 months ago' +%F >/dev/null 2>&1; then
  cutoff=$(date -u -d '12 months ago' +%F)   # GNU date (CI)
else
  cutoff=$(date -u -v-12m +%F)               # BSD date (macOS)
fi

# Extract entry repos (owner/repo) from list-item GitHub links.
repos=$(grep -oE '^- \[[^]]+\]\(https://github.com/[^)]+\)' "$README" \
  | grep -oE 'github\.com/[^/)#]+/[^/)#]+' | sed 's#github\.com/##' | sort -u)
total=$(printf '%s\n' "$repos" | grep -c .)

dead=""; n_dead=0
arch=""; n_arch=0
stale=""; n_stale=0
# A renamed repo still answers 200 through GitHub's redirect, so link-rot alone never
# sees it. Two things hide behind that: the link is no longer canonical, and if the
# new name is also listed the list now carries the same repo twice.
ren=""; n_ren=0

for r in $repos; do
  if ! out=$(gh api "repos/$r" --jq '(.archived|tostring)+" "+(.pushed_at|.[0:10])+" "+.full_name' 2>/dev/null); then
    dead="${dead}- \`${r}\`"$'\n'; n_dead=$((n_dead + 1)); continue
  fi
  a=${out%% *}; rest=${out#* }; p=${rest%% *}; canon=${rest##* }
  [ "$a" = "true" ] && { arch="${arch}- \`${r}\` (pushed ${p})"$'\n'; n_arch=$((n_arch + 1)); }
  [[ "$p" < "$cutoff" ]] && { stale="${stale}- \`${r}\` (pushed ${p})"$'\n'; n_stale=$((n_stale + 1)); }
  if [ "$(printf '%s' "$canon" | tr 'A-Z' 'a-z')" != "$(printf '%s' "$r" | tr 'A-Z' 'a-z')" ]; then
    ren="${ren}- \`${r}\` -> \`${canon}\`"$'\n'; n_ren=$((n_ren + 1))
  fi
done

{
  echo "## Link-rot report — ${today}"
  echo
  echo "- Checked: ${total} entry links"
  echo "- Dead: ${n_dead}"
  echo "- Archived: ${n_arch}"
  echo "- Stale (>12 months): ${n_stale}"
  echo "- Renamed upstream: ${n_ren}"
  [ "$n_dead"  -gt 0 ] && { echo; echo "### ❌ Dead links (fix or remove)"; printf '%s' "$dead"; }
  [ "$n_arch"  -gt 0 ] && { echo; echo "### 📦 Archived (review — a frozen model repo is often fine)"; printf '%s' "$arch"; }
  [ "$n_stale" -gt 0 ] && { echo; echo "### 🕸 Stale >12 months (review)"; printf '%s' "$stale"; }
  [ "$n_ren"   -gt 0 ] && { echo; echo "### 🔀 Renamed upstream (relink, and check we do not list both names)"; printf '%s' "$ren"; }
} | tee report.md

[ "$n_dead" -eq 0 ]
