#!/usr/bin/env bash
# House-style check for entry descriptions.
# awesome-lint checks *format*; this checks the parts of the house style that are
# mechanically decidable (naming canon, length ceiling, punctuation, self-repetition).
#
# Exits nonzero only on ERRORs. WARNs are review candidates that need human judgment
# (a banned adjective is allowed when evidence follows it immediately), so they never
# block a push on their own.
#
# Runs locally (macOS/Linux) and in CI. Bash + grep + awk only.
set -uo pipefail

README="${1:-README.md}"
err=0
warn=0

# Entry lines only: "- [owner/repo](https://github.com/...) - Description."
# Section TOC links (- [Name](#anchor)) are skipped by requiring the https:// prefix.
entries=$(grep -nE '^- \[[^]]+\]\(https://[^)]+\) - ' "$README")
total=$(printf '%s\n' "$entries" | grep -c .)

report() {  # report <ERROR|WARN> <line> <rule> <message>
  printf '%-5s L%-5s %-28s %s\n' "$1" "$2" "$3" "$4"
  [ "$1" = ERROR ] && err=$((err + 1)) || warn=$((warn + 1))
  return 0
}

while IFS= read -r entry; do
  ln=${entry%%:*}
  rest=${entry#*:}
  desc=${rest#*) - }
  words=$(printf '%s' "$desc" | wc -w | tr -d ' ')
  # Naming canon applies to prose, not to quoted literals: a flag value, tag or
  # filename inside backticks has exactly one correct spelling and it is upstream's
  # (`--kv-cache-dtype nvfp4`, `linux/arm64`). Strip code spans before the S5 checks.
  prose=$(printf '%s' "$desc" | sed 's/`[^`]*`//g')

  # ---- S5 naming canon (ERROR: one spelling per thing, no exceptions) ----
  printf '%s' "$prose" | grep -qE '\bSM_?121\b' \
    && report ERROR "$ln" "S5/sm_121-casing" "use sm_121, not $(printf '%s' "$prose" | grep -oE '\bSM_?121\b' | head -1)"
  # aarch64 canon. Carve-out: keep upstream spelling when the word names an artifact
  # (Docker/NGC platform tags are literally linux/arm64), so only flag bare platform use.
  if printf '%s' "$prose" | grep -qiE '\bARM64\b'; then
    printf '%s' "$prose" | grep -qiE '\b(arm64 (nvcr|image|container|wheel|tag|build|binary)|linux/arm64|[-/]arm64\b)' \
      || report ERROR "$ln" "S5/aarch64-canon" "use aarch64 for the platform (arm64 only when naming an artifact tag)"
  fi
  printf '%s' "$prose" | grep -qE '\bDGX-Spark\b|\bDGX SPARK\b|\bdgx spark\b' \
    && report ERROR "$ln" "S5/DGX-Spark-casing" "canon is 'DGX Spark'"
  printf '%s' "$prose" | grep -qE '\bNvidia\b|\bNVidia\b' \
    && report ERROR "$ln" "S5/NVIDIA-casing" "canon is 'NVIDIA'"
  printf '%s' "$prose" | grep -qE '\bnvfp4\b' \
    && report ERROR "$ln" "S5/NVFP4-casing" "canon is 'NVFP4'"

  # ---- S7 length + punctuation ----
  [ "$words" -gt 30 ] \
    && report ERROR "$ln" "S7/hard-cap" "$words words (>30: the entry is doing two jobs)"
  printf '%s' "$desc" | grep -q ';' \
    && report ERROR "$ln" "S7/semicolon" "semicolons are not used in descriptions"
  printf '%s' "$desc" | grep -qE '[—–]' \
    && report ERROR "$ln" "S7/dash" "em/en dashes are not used in descriptions"
  [ "$(printf '%s' "$desc" | tr -cd ':' | wc -c | tr -d ' ')" -gt 1 ] \
    && report ERROR "$ln" "S7/colon" "at most one colon, to introduce a capability list"

  # ---- S8 self-repetition (same referent twice) ----
  [ "$(printf '%s' "$desc" | grep -oE 'DGX Spark' | wc -l | tr -d ' ')" -gt 1 ] \
    && report ERROR "$ln" "S8/repeat" "'DGX Spark' appears twice"
  [ "$(printf '%s' "$desc" | grep -oE 'GB10' | wc -l | tr -d ' ')" -gt 1 ] \
    && report ERROR "$ln" "S8/repeat" "'GB10' appears twice"

  # ---- S0 article start ----
  printf '%s' "$desc" | grep -qE '^(A|An|The) ' \
    && report ERROR "$ln" "S0/article" "descriptions do not open with A/An/The"

  # ---- S7 evidence density: past 16 words, every clause must carry evidence ----
  # Mechanical proxy: a long line with no digit and no named technique is prose bloat.
  if [ "$words" -gt 16 ]; then
    printf '%s' "$desc" | grep -qE '[0-9]' \
      || printf '%s' "$desc" | grep -qiE 'NVFP4|DFlash|MTP|TurboQuant|CUTLASS|Marlin|NCCL|RoCE|RDMA|vLLM|SGLang|llama\.cpp|TensorRT|FlashInfer|SageAttention|MoE|GGUF|INT4|FP8|AWQ|LoRA|Triton|CUDA|sm_121|unified.memory|zero-copy|one-command' \
      || report WARN "$ln" "S7/evidence-density" "$words words with no number and no named technique"
  fi

  # ---- S3 banned vocabulary (WARN: allowed when evidence follows immediately) ----
  hit=$(printf '%s' "$desc" | grep -oiE '\b(optimized|powerful|comprehensive|definitive|ultimate|simple|easy|helpful|robust|seamless|intuitive|flexible|scalable|production-ready|enterprise-grade|cutting-edge|state-of-the-art|blazing|lightning-fast|next-gen|world-class|beautiful|stunning|sleek|gorgeous|slick|boasts|empowers|unlocks|supercharges|revolutionizes)\b' | head -1)
  [ -n "$hit" ] && report WARN "$ln" "S3/banned-word" "'$hit' — delete it or make the evidence adjacent"
  tail=$(printf '%s' "$desc" | grep -oiE '\b(enabling|leveraging|ensuring|allowing)\b' | head -1)
  [ -n "$tail" ] && report WARN "$ln" "S3/ing-tail" "'$tail' — superficial -ing tail"

  # ---- S1 evaluative opener (WARN: classifying modifiers are fine and common) ----
  printf '%s' "$desc" | grep -qE '^(Optimized|Fast|Powerful|Complete|Comprehensive|Ultimate|Simple|Easy|Advanced|Modern|Clean|Beautiful) ' \
    && report WARN "$ln" "S1/evaluative-opener" "opens with an evaluative adjective"
done <<< "$entries"

# ---- Structure: a stray blank line silently splits a list, and awesome-lint
# ---- does not catch it. Caught in the wild on 2026-07-25 during an insert.
struct=$(awk '
  /^#/    { if (NR > 1 && prev != "") printf "ERROR L%-5s %-28s %s\n", NR, "MD/heading-spacing", "heading must be preceded by a blank line" }
  /^$/    { if (prev ~ /^- \[/) blankafter = NR; prev = ""; next }
  /^- \[/ { if (blankafter && blankafter == NR - 1) printf "ERROR L%-5s %-28s %s\n", blankafter, "MD/list-split", "blank line splits an entry list"; blankafter = 0 }
          { prev = $0 }
' "$README")
if [ -n "$struct" ]; then
  printf '%s\n' "$struct"
  err=$((err + $(printf '%s\n' "$struct" | grep -c .)))
fi

echo
echo "checked $total entry descriptions: $err error(s), $warn warning(s)"
[ "$err" -eq 0 ] || { echo "style-check failed — fix the ERRORs above."; exit 1; }
echo "style-check passed (warnings are review candidates, not blockers)."
