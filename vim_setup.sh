#!/bin/bash

howToUse() {
		scriptName=`basename $0`
        echo "./$scriptName [option] [fileName]"
		exit 1
}

macReadlink() {
	TARGET_FILE=$1
	cd `dirname $TARGET_FILE`
	TARGET_FILE=`basename $TARGET_FILE`

	while [ -L "$TARGET_FILE" ]
	do
		TARGET_FILE=`readlink $TARGET_FILE`
		cd `dirname $TARGET_FILE`
		TARGET_FILE=`basename $TARGET_FILE`
	done

	PHYS_DIR=`pwd -P`
	RESULT=$PHYS_DIR/$TARGET_FILE
	echo $RESULT
}

option=$1

verifiedFstarOption="-verifiedFstar" 
execFstarOption="-execFstar"

verifiedLowStarOption="-verifiedLowStar" 
execLowStarOption="-execLowStar"

if [ "$option" = "$verifiedFstarOption" ]; then
        echo "verifiedFstar mode."
elif [ "$option" = "$execFstarOption" ]; then
        echo "execFstar mode."
elif [ "$option" = "$verifiedLowStarOption" ]; then
        echo "verifiedLowStar mode."
elif [ "$option" = "$execLowStarOption" ]; then
        echo "execLowStar mode."
else
	howToUse
fi

fileName=$2

fileFullPath=`readlink -f $fileName 2>/dev/null || macReadlink $fileName`
dirFullPath=`dirname $fileFullPath`
fstarExtention=".fst"
baseFileName=`basename $fileFullPath $fstarExtention`
firstUpperBaseFileName=`echo $baseFileName | awk '{print toupper(substr($1,1,1))substr($1,2)}'`
outDirPath=$dirFullPath/out
generatedOcamlPath=$outDirPath/$baseFileName.ml
execFileName="a.out"
execFilePath=$dirFullPath/$execFileName
tempDir=`mktemp -d`
cd $tempDir

if [ "$option" = "$verifiedFstarOption" ]; then
	fstar $fileFullPath
elif [ "$option" = "$execFstarOption" ]; then
	cat << EOS > Makefile
include $FSTAR_HOME/ulib/ml/Makefile.include

all:
	fstar $fileFullPath --odir $outDirPath --codegen OCaml --extract '$baseFileName'
	\$(OCAMLOPT) -o $execFilePath $generatedOcamlPath
	$execFilePath
EOS
	make 
elif [ "$option" = "$verifiedLowStarOption" ]; then
        krml -verify -skip-extraction -skip-translation -skip-compilation  -skip-linking $fileFullPath 
elif [ "$option" = "$execLowStarOption" ]; then
        krml -verify -drop WasmSupport -tmpdir $outDirPath -no-prefix $firstUpperBaseFileName $fileFullPath && ./a.out && echo "done"
else
	howToUse
fi
