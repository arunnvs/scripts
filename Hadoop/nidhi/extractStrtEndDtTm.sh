#!/bin/bash
outfile="withDtTm"$1
awk -f addDate_Time2.awk $1 > $outfile
