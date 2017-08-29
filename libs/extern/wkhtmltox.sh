#!/bin/bash
# Run to install wkhtmltopdf in local folder
version="0.12.4"
wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/$version/wkhtmltox-"$version"_linux-generic-amd64.tar.xz
tar xf wkhtmltox-"$version"_linux-generic-amd64.tar.xz
