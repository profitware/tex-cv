
# Pdflatex
PDFLATEX='pdflatex -interaction=nonstopmode -shell-escape -file-line-error'

# Файлы/Папки
PDF_NAME='out/document.pdf'
TEX='src'
IMG='img'
MAINTEX='tex-cv'

# Конвертация eps
find $IMG/ -type f -name "*.eps" -exec epstopdf {} ";" ;
find $IMG -type f -name "*.eps" -exec rm -f {} \;

# Сборка latex
cd src
$PDFLATEX $MAINTEX > /dev/null
BIBOUTPUT=$(bibtex $MAINTEX)
# Показывать output bibtex'a только в случае ошибок
if [[ "$BIBOUTPUT" =~ "error" ]]; then
    echo "$BIBOUTPUT"
fi
$PDFLATEX $MAINTEX > /dev/null
$PDFLATEX $MAINTEX

cp $MAINTEX.pdf ../$PDF_NAME
cd ..

# Clear
find $TEX/ -maxdepth 1 -type f ! -regex ".*\.tex$" -exec rm -f {} \; ;

