#!/bin/bash

build=build
project_582=PetrasVaclav_ProjectPresentation

# how many times repeat latex
n=3

function tex_to_pdf {
    for i in $(eval echo {1..$n}); do pdflatex $1; done
}

set -e

sed -e "s/aspectratio=1610/aspectratio=169/g" < ${project_582}.tex > ${project_582}_16x9.tex
sed -e "s/aspectratio=1610/aspectratio=43/g" < ${project_582}.tex > ${project_582}_4x3.tex

tex_to_pdf ${project_582} &
tex_to_pdf ${project_582}_16x9 &
tex_to_pdf ${project_582}_4x3 &
wait

echo done

cp ${project_582}.pdf $build
cp ${project_582}_16x9.pdf $build
cp ${project_582}_4x3.pdf $build
cp ${project_582}.pdf $build/${project_582}_16x10.pdf

cp index.html ${build}/index.html

mkdir -p ${build}/images
mkdir -p ${build}/images/features
cp images/features/fractals_plasio.png ${build}/images/features/fractals_plasio.png

rm ${project_582}_16x9.* ${project_582}_4x3.*
