# Contribution Guidelines

Thanks for helping make **Awesome DGX Spark** better. This list aims for one thing: a DGX Spark owner should be able to trust every line. The five principles below are how we keep it that way. Read them before opening a pull request.

## The five principles

### 1. Explicitly about the DGX Spark

The project must explicitly target the GB10 / sm_121(a) platform in its own README or code — aarch64 builds, sm_121 kernels or patches, NVFP4 on Blackwell, unified-memory handling, multi-Spark fabric — or publish results measured on a real DGX Spark. Generic CUDA or LLM tooling that merely runs on a Spark like any other GPU does not qualify. Rule of thumb: if the repository's own body never mentions DGX Spark, GB10, or sm_121, it is out.

Supporting the chip is not the same as measuring on it. A project that targets several Blackwell parts (sm_120 and sm_121, for example) qualifies when it shows results from GB10 hardware, not only a build flag or a dispatch entry for sm_121.

### 2. Honest, evidence-backed descriptions

One line, in your own words, starting with what the thing *is*. Opening with a classifying modifier is fine, because it states a fact — "One-command installer…", "Prebuilt wheel…", "Read-only diagnostic CLI…". Opening with a judgment is not: "Optimized…", "Powerful…", "Complete…". The test is whether dropping the word removes a fact or only removes praise. No marketing language: any quality claim ("fast", "optimized", "comprehensive") must be backed on the spot by a number, a named technique, or a concrete capability, otherwise drop it. When you cite a number, cite the one that proves the contribution, not the most impressive-looking one. The bar: the line should survive Hacker News without being called either hype or "so what does it actually do?".

### 3. Proof of function

Include verifiable evidence: benchmark numbers (with the software and driver versions used, so results stay interpretable as the stack moves), working commands, or a build reproducible from source. Prefer source-reproducible projects; if an entry is binary-only (a wheel or image that cannot be rebuilt from source), say so in the description, and never link to entries hosted on unknown third-party mirrors. A results table that is still empty, or a README that says the run or the weights upload is still pending, does not count as proof yet.

### 4. Maintained

A new entry must have been active within the last 12 months, and abandoned projects are declined. The platform moves fast, and a project pinned to a stale CUDA, driver, or vLLM version that no longer builds is not useful to a Spark owner today. Archiving alone is not treated as abandonment: a finished project is often archived too. Once listed, a project is not removed for age alone (see [How entries leave](#how-entries-leave)).

### 5. Canonical and non-duplicate

Link to the canonical repository, not a redirect or mirror — if a project was transferred to an organization, link the new home. One entry per project; a near-duplicate is accepted only if it offers a meaningfully different and demonstrably better approach. When a new model lands and many repositories appear within days, each distinct approach gets one entry: how the model was made to fit (engine, offload path, quantization, number of nodes) together with the numbers it produced. A second project with the same approach and similar numbers is a duplicate. Keep entries in alphabetical order within their section.

## Entry format

```markdown
- [owner/repo](https://github.com/owner/repo) - Short description ending with a period.
```

- Start the description with an uppercase letter and end it with a period.
- Do not start with "A", "An", or "The".
- Keep it to one line, free of marketing language (principle 2).
- Separate the link and the description with ` - ` (space-hyphen-space), not an em dash.
- Aim for about 16 words. Longer is fine when every added clause carries a number or a named technique; 30 words is the ceiling. Padding a line with prose is not.
- Spell the platform the way the rest of the list does: `DGX Spark`, `GB10`, `sm_121`, `NVFP4`, `aarch64`, `NVIDIA`. Use `arm64` only when naming an artifact whose own tag is `arm64` (a Docker platform, for instance).
- No semicolons or em/en dashes inside the description, and at most one colon, used to introduce a list.

A pre-push hook and CI run `.github/scripts/style-check.sh`, which enforces the mechanical parts of the above. You can run it yourself with `bash .github/scripts/style-check.sh README.md`.

## Keeping entries true

A description is a claim, and claims expire. A project that was a benchmark when it was added acquires a newer version; a number in our line gets retracted upstream; a one-line entry stops describing what the project has become. None of that shows up as a broken link, so a weekly job runs `.github/scripts/entry-drift.sh`, which dates each line with `git blame` and counts how much its repository has committed since. It produces a reading list, not a failure — a human re-reads the flagged projects and rewrites the lines that no longer hold.

If you maintain a project listed here and it has moved past its description, open a pull request that updates the line. Correcting a stale entry is as welcome as adding a new one, and pointing at the evidence is enough — you do not need to argue for inclusion again.

## How entries leave

An entry is removed when one of these holds:

- The same model class now has a successor in the list, and the entry's value was only how to run the older model. Techniques outlive their test model: kernels, quantization recipes, engines, fine-tuning setups and serving images stay even when they were measured on an older checkpoint.
- The fix it carries has been merged upstream, so readers already have it, or the problem it works around no longer exists on current drivers and toolchains.
- Another listed project covers the same approach more completely, and this entry adds nothing the other one lacks.
- On re-reading, it no longer meets principle 1 or 3: the project has moved away from GB10, or the evidence behind it was withdrawn upstream.
- The repository is unreachable on two checks several days apart. A single 404 can be a temporary suspension, so one failed check never removes an entry.
- It has become a fork or mirror of a project that is already listed.

Entries are not removed for a low star count, for age alone, for a quiet commit history in a finished guide or container, for being archived, or for modest throughput numbers. A large model on a small machine is supposed to produce small numbers. When a line has fallen behind its project, we rewrite the line instead of removing the entry.

Removal commits describe the change to the list and say nothing about the project itself.

## Self-submissions

Self-submissions are welcome and evaluated by the same five principles as any other entry. Please disclose the affiliation in your pull request description.

## Submitting a pull request

1. Fork the repo and add your entry to the most appropriate section, in alphabetical order.
2. Update the Contents table of contents if you add a new section.
3. Open a pull request that names the project and points to the evidence behind principles 1, 3, and 4 (the Spark-specific content, the proof of function, and recent activity).
4. One pull request per logical addition is preferred.

We may rewrite the description of an accepted entry to match the rest of the list, in a separate commit after the merge.

By contributing, you agree that your contribution is released under [CC0 1.0](LICENSE).
