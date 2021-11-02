#!/bin/bash

# get commit id
COMMIT=`git log --pretty=format:'%h' -n 1`

# create and clean output directories
mkdir -p {out/resources,out/matches}
rm -f out/resources/*
rm -f out/matches/*

# download the tool


# for each app, run the tool
for FILE in apps/*; do
  arrFILE=(${FILE//\// })
  arrFILENAME=(${arrFILE[1]//\./ })
  APP_NAME=${arrFILENAME[0]}

  ./design-as-code -app=$FILE -patternlib=patterns/vmc.hcl -mode=describe -json=out/resources/$COMMIT-$APP_NAME-describe.json
  ./design-as-code -app=$FILE -patternlib=patterns/vmc.hcl -mode=match -json=out/matches/$COMMIT-$APP_NAME-matches.json
done

# now upload to S3
aws s3 sync out/resources/ s3://$BUCKET/resources/
aws s3 sync out/matches/ s3://$BUCKET/matches/

