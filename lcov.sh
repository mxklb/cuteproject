#!/bin/bash
# Generates a .tar.gz compressed lcov html report and a pdf.
#
# Note: Run "gcovr -r ." before using this script!
#
# Depends on wkhtmltopdf.org and xvfb

reportname="coverage"

# Working directory
folder="coverage/"
mkdir $folder

# A] Create a compressed lcov coverage report from . directory
lcov --directory . --capture --output-file "$folder"app.info
genhtml --output-directory $folder "$folder"app.info
tar czf "$reportname".tar.gz $folder
mv "$reportname".tar.gz $folder

# B] Create a pdf from html
outfile="$reportname.pdf"

# 1 Find all index.html and *.gcov.html files (genhtml)
# 2 Generates one pdf out of all matching files sorted by name
files=$(find "$folder" -name index.html)
files=$files"\n"$(find "$folder" -name *.gcov.html)
files=$(echo -e "$files" | sort)
files=$files" "$folder$outfile

# Execute wkhtmltopdf.sh install script
chmod +x libs/extern/wkhtmltox.sh && libs/extern/wkhtmltox.sh
chmod +x wkhtmltox/bin/wkhtmltopdf

# Convert html to pdf
xvfb-run --server-args="-screen 0, 1024x768x24" wkhtmltox/bin/wkhtmltopdf --disable-external-links --footer-center [page] $files
