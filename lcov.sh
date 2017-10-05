#!/bin/bash
# Generates a .tar.gz compressed lcov html report and a pdf from . directory.
#
# Note: Run gcovr -r . -e '.*extern.*' -e '.*moc_.*' before this script!
#
# This scripts depends on
# - wget [to download wkhtmltopdf binary]
# - xvfb [for headless html2pdf rendering]

reportname="coverage"

# Working directory
folder="coverage"
mkdir $folder

# Prepare for lcov, remove moc_* files coverage
find . -name "moc_*.gcda" -delete
find . -name "moc_*.gcno" -delete

# A] Create a compressed lcov coverage report from . directory (ignore libs/extern)
lcov --directory . --capture --output-file $folder/app.info --no-external
lcov --remove $folder/app.info "libs/extern/*" -o $folder/app.info
genhtml --output-directory $folder $folder/app.info
tar czf $reportname.tar.gz $folder
mv $reportname.tar.gz $folder

# B] Create a pdf from html
outfile=$reportname.pdf

# Find all index.html and *.gcov.html files (see genhtml)
indexFiles=$(find $folder -name index.html -printf "%d %p\n" | sort -n | perl -pe 's/^\d+\s//;')
otherFiles=$(find $folder -name *.gcov.html | sort)
files=$(echo -e $indexFiles $otherFiles $folder/$outfile)

# Execute wkhtmltopdf.sh to wget wkhtmltox-*_linux-generic-amd64 binary
chmod +x libs/extern/wkhtmltox.sh && libs/extern/wkhtmltox.sh
chmod +x wkhtmltox/bin/wkhtmltopdf

# Convert html to pdf
xvfb-run --server-args="-screen 0, 1024x768x24" wkhtmltox/bin/wkhtmltopdf --disable-external-links --footer-center [page] $files
