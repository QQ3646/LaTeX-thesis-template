# Master Diploma LaTeX Template (RU)

A minimal LaTeX template for a Russian-language diploma/thesis. It uses `extarticle` with 14pt on A4, Russian fonts/layout, and a clean chapter structure. An optional assembly step lets you prepend an officially approved title page PDF.

## Repository Structure

- [main.tex](main.tex): Entry point; includes preamble and chapter files.
- [preamble.tex](preamble.tex): Packages, fonts, spacing, geometry, and listings/algorithms setup.
- [chapters/](chapters/): Per-section content files.
  - [chapters/0-title.tex](chapters/0-title.tex): Title and author; renders with `\maketitle`.
  - [chapters/1-contents.tex](chapters/1-contents.tex): Table of contents via `\tableofcontents`.
  - [chapters/2-introduction.tex](chapters/2-introduction.tex): Starter for your Introduction.
- [assemble/assemble.tex](assemble/assemble.tex): Produces a final PDF that prepends an external official title page (PDF) to the compiled thesis.
- [setup.sh](setup.sh): Optional git hooks setup for POSIX shells.

## Requirements

- TeX distribution: MiKTeX (Windows) or TeX Live (Windows/macOS/Linux)
- Recommended tool: `latexmk` (automates multiple runs)
- Optional: Inkscape (only if you plan to include SVGs with the `svg` package)

Packages used are declared in [preamble.tex](preamble.tex) and will be installed automatically by MiKTeX/TeX Live if configured to do so (e.g., `tempora`, `newtxmath`, `babel` with Russian, `algorithm`, `listings`, `svg`, etc.).

## Quick Start

1) Create a build directory (if you plan to use `pdflatex` directly):

```bash
mkdir -p build
```

2) Compile the main document (choose one):

- Using latexmk (recommended):

```bash
latexmk -pdf -shell-escape -interaction=nonstopmode -halt-on-error -outdir=build main.tex
```

- Using pdflatex (run twice for TOC):

```bash
pdflatex -interaction=nonstopmode -halt-on-error -output-directory build main.tex
pdflatex -interaction=nonstopmode -halt-on-error -output-directory build main.tex
```

The output will be at `build/main.pdf`.

## Windows Notes (MiKTeX)

- Use the MiKTeX Console to enable on-the-fly package installation.
- If `latexmk` isn’t available, install it via MiKTeX package manager or use the two-step `pdflatex` commands above.
- If you include SVGs with `\includesvg{...}`, ensure Inkscape is installed and on your PATH. Otherwise, prefer PDF/PNG via `\includegraphics{...}`.

## Assemble Final PDF (with official title page)

To generate a full PDF with the official title page manually, run ./scripts/build_final.sh

Note: If you have configured the Git Hooks (see below), this assembly process happens automatically on every commit if any .tex or .bib files are changed.

### Manual Assembly

The assembler combines an external official title page PDF with your thesis PDF:

- Place your official title page as [assemble/title.pdf](assemble/title.pdf).
- Ensure [build/main.pdf](build/main.pdf) already exists (compiled from [main.tex](main.tex)).
- Build the assembled document:

```bash
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build assemble/assemble.tex
```

This produces `build/assemble.pdf` that includes `title.pdf` as the first page and `main.pdf` from page 2 onward (see [assemble/assemble.tex](assemble/assemble.tex)).

## Editing Guide

- Title/Author: Edit [chapters/0-title.tex](chapters/0-title.tex). The placeholder author line reminds you to remove the page before final submission.
- Contents: [chapters/1-contents.tex](chapters/1-contents.tex) already calls `\tableofcontents`.
- Chapters/Sections: Create new files under [chapters/](chapters/) (e.g., `3-related-work.tex`) and add corresponding `\include{chapters/3-related-work}` lines in [main.tex](main.tex).
- Graphics/Tables:
  - Use `graphicx` via `\includegraphics{path}` for PNG/PDF images.
  - Use `longtable`, `multirow` for complex tables; see [preamble.tex](preamble.tex).
- Code/Algorithms: `listings` and `algorithm/algpseudocode` are pre-configured in [preamble.tex](preamble.tex). Example language is set to Java; adjust with `\lstset{language=...}` as needed.

## Formatting Details

- Class: `extarticle` with options `[a4paper,14pt,russian]` (see [main.tex](main.tex)).
- Fonts: `tempora` (Times-like with Cyrillic) and `newtxmath` for math.
- Spacing: `\onehalfspacing` and first-paragraph indentation enabled.
- Margins: `left=30mm, right=10mm, top=20mm, bottom=20mm`.
- TOC depth and numbering up to subparagraphs are enabled.
- Hyperlinks are enabled (hidden style) via `hyperref` + `hypcap`.

## Troubleshooting

- TOC or references not updating: run `latexmk -pdf` or repeat `pdflatex` to resolve cross-references.
- Cyrillic issues: ensure your engine is `pdfLaTeX` with `inputenc` (UTF-8) and `fontenc` T2A as configured in [preamble.tex](preamble.tex). If your environment still misbehaves, try updating MiKTeX/TeX Live packages.
- Missing packages: allow automatic install or manually install via package manager. Then rebuild.
- SVG conversion: install Inkscape and keep it on PATH; otherwise convert SVGs to PDF/PNG manually.

## Optional: Git Hooks

The repo includes [setup.sh](setup.sh) to point Git to the `.githooks` directory. On Windows, run it under Git Bash or set the hooks path manually:

```bash
git config core.hooksPath .githooks
```
