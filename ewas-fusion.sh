#!/bin/bash
#1-5-2017 MRC-Epid JHZ

#parallel '/bin/echo {1} {2} /genetics/bin/FUSION/GTEx/{1}' ::: $(/bin/cat ../GTEx.list) ::: $(seq 22)>../GTEx.runlist

if [ $# -lt 1 ] || [ "$1" == "-h" ]; then
    echo "Usage: gtex-sge.sh <input>"
    echo "where <input> is in tab-delimited format:"
    echo "SNP A1 A2 Z N"
    echo "The output is contained in <$1.tmp>"
    exit
fi
dir=$(pwd)/$(basename $1).tmp
if [ ! -d $dir ]; then
   mkdir -p $dir
fi
FUSION=/genetics/bin/FUSION/tests
ln -sf $FUSION/glist-hg19 $dir/glist-hg19
qsub -cwd -sync y -v FUSION=$FUSION -v dir=$dir -v sumstats=$(pwd)/$1 -v GTEx=/genetics/bin/FUSION/GTEx/ $FUSION/gtex-fusion.qsub
