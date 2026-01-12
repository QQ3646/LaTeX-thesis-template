# Master Diploma LaTeX Template (RU)

A minimalist LaTeX template for a Russian-language Master's thesis. It is pre-configured to meet standard Russian academic requirements (14pt, A4, Times-like fonts, 1.5 line spacing, and GOST-compliant bibliography).

## Repository Structure

- `main.tex` — Entry point. Handles document structure and logic for switching between draft and official title pages.
- `preamble.tex` — Centralized configuration: packages, fonts, margins, and code listing styles.
- `bib/references.bib` — Bibliography database (BibLaTeX/Biber).
- `chapters/` — Individual `.tex` files for each section (Introduction, Chapters, etc.).
- `img/` — Directory for all your images (PNG, JPG, SVG).
- `scripts/build_final.sh` — Master build script. It ignores `includeonly`, assembles the final PDF with the official title page, and preserves all hyperlinks.
- `assembly/` — Folder for your official title page (`title.pdf`).
- `.githooks/` — Pre-commit automation to ensure the root `main.pdf` is always up to date.

## Requirements

- **TeX Distribution:** MiKTeX (recommended for Windows) or TeX Live.
- **Build Tool:** `latexmk` (included with most TeX distributions).
- **Inkscape:** **Required** for SVG support. Ensure Inkscape is installed and added to your system `PATH`.

## Initialization

1. **Setup Git Hooks** to enable automatic PDF generation before every commit:
   ```bash
   git config core.hooksPath .githooks
   ```
2. **Install Dependencies:** On the first run, MiKTeX will automatically prompt you to install missing packages (e.g., `tempora`, `newtxmath`, `svg`, `biblatex-gost`).

## Workflow

### Local Development (Fast)
To speed up compilation while writing, use the following command in `main.tex`:
```latex
\includeonly{chapters/2-introduction}
```
VS Code (with the LaTeX Workshop extension) will then only compile that specific chapter.

### Manual Full Build
To generate the entire thesis with the official title page (ignoring any `includeonly` settings), run:
```bash
sh scripts/build_final.sh
```
The final result will be saved as `main.pdf` in the root directory.

### Automated Commits
When you perform a `git commit`, the pre-commit hook checks for changes in `.tex` or `.bib` files. If changes are detected, it triggers the full build script and automatically stages the updated `main.pdf` to your commit.

## Official Title Page
If you have an officially approved title page in PDF format:
1. Place it in the `assembly/` folder and name it `title.pdf`.
2. The build script will automatically include it as the first page.
3. **Note:** This method preserves all internal hyperlinks and citations.

## Editing Guide

- **Chapters:** Create new `.tex` files in `chapters/` and include them in `main.tex` using the `\include` command.
- **Bibliography:** Add your sources to `bib/references.bib`. Use `\cite{key}` for in-text citations.
- **Graphics:** Place all images in the `img/` folder. The template is configured to find them automatically, so you only need the filename:
  - For SVG: `\includesvg[width=\textwidth]{my_vector_file}`
  - For PNG/JPG: `\includegraphics[width=\textwidth]{my_photo}`
- **Formatting:** Margins (Left 30mm, Right 10mm, Top/Bottom 20mm) and 1.5 line spacing are pre-configured in `preamble.tex`.

## Troubleshooting
- **Bibliography not updating:** Ensure `latexmk` is calling `biber`. If numbers are wrong, delete the `build/` folder and rebuild.
- **SVG Errors:** Ensure Inkscape is in your system `PATH`. The build command **must** include the `-shell-escape` flag (which is already included in `build_final.sh`).
