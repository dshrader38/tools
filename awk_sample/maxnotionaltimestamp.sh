#!/bin/sh

for filename in  "$@"
do
  awk 'BEGIN{max=0;timestamp="";} {if ( $0 ~ /current exposure to/) {sub("<","", $NF);sub(">","", $NF);if($NF>max){max=$NF; timestamp=$0}} } END {fname = FILENAME; sub(/.*\//, "",fname); sub(/OrderManagerService./, "",fname);  sub(/.log/, "",fname); print substr(timestamp,0,23) ": " max}' $filename
done
