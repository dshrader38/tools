#!/bin/sh

for filename in  "$@"
do
  awk 'BEGIN{max=0;} {if ( $0 ~ /current exposure to/) {sub("<","", $NF);sub(">","", $NF);if($NF>max){max=$NF}} } END {fname = FILENAME; sub(/.*\//, "",fname); sub(/OrderManagerService./, "",fname);  sub(/.log/, "",fname); print fname ": " max;}' $filename
done
