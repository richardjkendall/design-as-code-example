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

  # run describe
  ./design-as-code -app=$FILE -patternlib=patterns/vmc.hcl -mode=describe -json=out/resources/$COMMIT-$APP_NAME-describe.json
  # check exit code and halt if we had a problem
  if [ $? -eq 0 ]; then
    echo "success"
  else
    echo "there was an error"
    exit 1
  fi

  # run match
  # default is solve for priority
  ./design-as-code -app=$FILE -patternlib=patterns/vmc.hcl -mode=match -json=out/matches/$COMMIT-$APP_NAME-matches.json
  # check exit code and halt if we had a problem
  if [ $? -eq 0 ]; then
    echo "success"
  else
    echo "there was an error"
    exit 1
  fi

done

# now upload to S3
aws s3 sync out/resources/ s3://$BUCKET/resources/
aws s3 sync out/matches/ s3://$BUCKET/matches/

