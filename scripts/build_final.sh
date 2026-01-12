#!/usr/bin/env sh

echo ">>> Starting Final Build Process..."

TEMP_MAIN="main_full.tex"
cp main.tex "$TEMP_MAIN"
sed -i 's/^[^%]*\\includeonly/%\\includeonly/g' "$TEMP_MAIN"

mkdir -p build
echo ">>> Running LaTeX..."

latexmk -pdf -shell-escape -interaction=nonstopmode -outdir=build -jobname=main "$TEMP_MAIN"
EXIT_CODE=$?

rm "$TEMP_MAIN"

if [ $EXIT_CODE -eq 0 ]; then
    cp build/main.pdf ./main.pdf
    echo ">>> SUCCESS: Final PDF generated in root."
else
    echo "!!! ERROR: LaTeX compilation failed!"
    exit 1
fi