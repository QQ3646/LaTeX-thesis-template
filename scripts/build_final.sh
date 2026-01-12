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

if [ $EXIT_CODE -ne 0 ]; then
    echo "!!! ERROR: LaTeX compilation failed!"
    exit 1
fi

if [ -d "assembly" ] && [ -f "assembly/assemble.tex" ]; then
    echo ">>> Merging official title page..."
    cd assembly
    pdflatex -interaction=nonstopmode -output-directory=../build assemble.tex > /dev/null
    cd ..
    
    if [ -f "build/assemble.pdf" ]; then
        cp build/assemble.pdf ./main.pdf
        echo ">>> SUCCESS: Final PDF assembled in root directory."
    else
        echo "!!! ERROR: Assembly failed!"
        exit 1
    fi
else
    echo ">>> NOTICE: /assembly/ not found. Using main.pdf without title."
    cp build/main.pdf ./main.pdf
fi

exit 0