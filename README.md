# Data Science Lab

`ds_lab` is a personal data science laboratory built with R and Quarto. It
collects small experiments, reusable notes, and selected work published as a
GitHub Pages website.

Website: <https://mpfoley73.github.io/ds_lab>

## Repository structure

- `experiments/` contains self-contained investigations and demonstrations.
- `notes/` contains concise reference material and reusable lessons.
- `docs/` contains the rendered website served by GitHub Pages.
- `_freeze/` contains Quarto's cached execution results.
- `_quarto.yml` defines the website, navigation, and output settings.

The source `.qmd` files, rendered `docs/` output, and `_freeze/` cache are
tracked in Git. Edit source documents and rerender the site; do not edit files
inside `docs/` manually.

## Add a note

Create a `.qmd` file directly under `notes/`, for example
`notes/my-new-note.qmd`:

```yaml
---
title: "My New Note"
date: 2026-10-18
description: "A short description of the note."
categories: [R, reproducibility]
---
```

Use a meaningful title, an ISO-formatted date (`YYYY-MM-DD`), a short
description, and a few relevant categories. The Notes page discovers the file
automatically.

## Add an experiment

Create new standalone experiments at `experiments/<topic>/index.qmd`. Keep
supporting files beside the document, adding subdirectories such as `data/` or
`assets/` only when they improve clarity.

Use **Question -> Experiment -> What I learned** as a light structure. Prefer
portable examples and document any required packages, external inputs, or
credentials without committing secrets or private data.

## Preview locally

From the repository root, start Quarto's local preview server:

```powershell
quarto preview
```

Preview is useful while drafting, but it is not the publishing step.

## Publish new content

1. Render the complete website from the repository root:

   ```powershell
   quarto render
   ```

   This writes the publishable site to `docs/` and updates listings, search,
   the sitemap, and any applicable frozen results.

2. Review what changed:

   ```powershell
   git status --short
   git diff --check
   git diff
   ```

   Confirm that the intended source file and its generated website files are
   included. Check that no credentials, private data, or unrelated files will
   be published.

3. Stage and commit the source and generated output. For a new note:

   ```powershell
   git add notes/my-new-note.qmd docs _freeze
   git commit -m "Add note about my topic"
   ```

4. Push the `master` branch:

   ```powershell
   git push origin master
   ```

5. After GitHub Pages finishes deploying, verify the page online and confirm
   that it appears in the appropriate listing and site search.

GitHub Pages is expected to publish from the `master` branch's `/docs` folder.
Pushing source without the regenerated `docs/` files will not update the live
site.

## Rendering notes

The project uses `freeze: auto`, so an ordinary site render can reuse cached
results for unchanged executable documents. When validating changed code or
dependencies, run the relevant computation rather than assuming an existing
frozen result proves it still works.
