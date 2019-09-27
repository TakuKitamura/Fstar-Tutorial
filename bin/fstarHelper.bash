#!/bin/bash

verifyFstarOption="-v"
verifyFstarOptionLabel="Verify Fstar"

execFstarOption="-e"
execFstarOptionLabel="Exec Fstar"

verifyLowStarOption="-vl"
verifyLowStarOptionLabel="Verify LowStar"

execLowStarOption="-el"
execLowStarOptionLabel="Exec LowStar"

usage() {
		scriptName=`basename $0`
        echo "usage: $scriptName [option] [fileName]"
		echo "option:"
		echo "  $verifyFstarOption   $verifyFstarOptionLabel"
		echo "  $execFstarOption   $execFstarOptionLabel"
		echo "  $verifyLowStarOption  $verifyLowStarOptionLabel"
		echo "  $execLowStarOption  $execLowStarOptionLabel"
		echo "fileName: Relative or Absolute Path"
		echo "# if you would like do other things, I need you to create Makefile in yourself."
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

if [ $# -ne 2 ]; then
	usage
fi

option=$1

if [ "$option" = "$verifyFstarOption" ]; then
        echo [$verifyFstarOptionLabel]
elif [ "$option" = "$execFstarOption" ]; then
        echo [$execFstarOptionLabel]
elif [ "$option" = "$verifyLowStarOption" ]; then
        echo [$verifyLowStarOptionLabel]
elif [ "$option" = "$execLowStarOption" ]; then
        echo [$execLowStarOptionLabel]
else
	usage
fi

fileName=$2
fstarExecFileName=fstar.exe
fileFullPath=`readlink -f $fileName 2>/dev/null || macReadlink $fileName`
dirFullPath=`dirname $fileFullPath`
fstarExtention=".fst"
baseFileName=`basename $fileFullPath $fstarExtention`
firstUpperBaseFileName=`echo $baseFileName | awk '{print toupper(substr($1,1,1))substr($1,2)}'`
outDirPath=$dirFullPath/out
generatedOcamlPath=$outDirPath/$firstUpperBaseFileName.ml
execFileName="a.out"
execFilePath=$dirFullPath/$execFileName
tempDir=`mktemp -d`
cd $tempDir

if [ "$option" = "$verifyFstarOption" ]; then
	$fstarExecFileName $fileFullPath
elif [ "$option" = "$execFstarOption" ]; then
	cat << EOS > Makefile
include $FSTAR_HOME/ulib/ml/Makefile.include

all:
	$fstarExecFileName $fileFullPath --odir $outDirPath --codegen OCaml --extract '$baseFileName'
	\$(OCAMLOPT) -o $execFilePath $generatedOcamlPath
	$execFilePath
EOS
	make 
elif [ "$option" = "$verifyLowStarOption" ]; then
        krml -verify -skip-extraction -skip-translation -skip-compilation  -skip-linking $fileFullPath 
elif [ "$option" = "$execLowStarOption" ]; then
        krml -verify -drop WasmSupport -tmpdir $outDirPath -no-prefix $firstUpperBaseFileName $fileFullPath && ./a.out
else
	usage
fi
