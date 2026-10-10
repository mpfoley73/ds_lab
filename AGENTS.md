# Working in ds_lab

## Purpose and collaboration

`ds_lab` is a personal data science laboratory, primarily using R and Quarto.
Use it for small, self-contained experiments, searchable reference notes, and
selected work published as a Quarto website through GitHub Pages.

- Read relevant source files before proposing or making changes.
- Prefer a useful prototype and iterative refinement over extensive planning.
- Explain why a technique or change works, concisely. Distinguish evidence,
  interpretation, and open questions.
- Make direct edits when requested and validate them when practical.
- Preserve existing content, filenames, and unrelated working-tree changes.
  Apply new conventions to new work; migrate existing work only when requested
  or necessary for the task.
- Keep infrastructure proportional to the experiment. Do not introduce a
  shared framework, dependency environment, or formal template by default.

## Organization and new experiments

- Use `experiments/<topic>/index.qmd` for a new standalone experiment.
- Book exercises may stay grouped under
  `experiments/do4ds/lab<N>/` with descriptive `.qmd` filenames.
- Keep supporting files beside the document. Add `R/`, `data/`, or `assets/`
  subdirectories only when they improve clarity.
- Use `notes/` for concise reference recipes, explanations, and reusable insights.

Give each new experiment a meaningful `title`, a `date` in `YYYY-MM-DD` format,
a short `description`, and a few consistent `categories` in its YAML front
matter. Reuse relevant existing categories before inventing new ones. Images
are optional.

Use **Question -> Experiment -> What I learned** as a light content structure.
Equivalent headings are fine. Capture what was tried, what happened, and when
the technique would be useful. Include setup details, limitations, and source
attribution when they help future reuse. Identify book-derived exercises and
link to the relevant material.

Prefer portable paths and minimal examples using built-in, synthetic, or public
data. Document required packages, external inputs, and credentials without
embedding secrets or private data.

## Reuse

Keep code local initially. When a second experiment needs the same pattern,
consider extracting a small shared helper or writing a recipe in `notes/`.
Reuse should follow demonstrated need, not anticipated possibilities.
Dependency isolation with `renv` or a Python environment is optional; use it
when an experiment's reproducibility needs justify it.

## Website and publishing

- `_quarto.yml` defines the website. `index.qmd` and `experiments/index.qmd`
  discover experiment pages recursively beneath experiment subdirectories,
  including their `index.qmd` files. Home shows the five most recent entries.
- A discoverable page can appear automatically in listings. Check publication
  intent before adding unfinished material; listing visibility alone does not
  control whether a page is rendered or published.
- `docs/` is the configured website output directory; `_freeze/` stores cached
  execution results with `freeze: auto`. Both are tracked. Preserve that policy
  unless a change is requested.
- Edit source documents and regenerate output rather than hand-editing generated
  HTML. Check that copied website resources contain only intended public files.
- Keep publishing separate from local editing and validation; publish when the
  user requests it.

## Validation and reporting

- Render the affected page when practical. For navigation or listing changes,
  render the affected hubs and check discovered pages and links.
- Use temporary output for validation when it would avoid disturbing existing
  generated work. Render the relevant content too when checking previews or
  execution results.
- Frozen output does not prove that changed code or dependencies execute
  successfully. Run the relevant computation when the task requires it.
- Run `git diff --check` after edits and review the diff for unintended changes.
- Report what changed, why, what was verified, and any remaining limitations.
  Do not claim a successful render or publication without evidence.
