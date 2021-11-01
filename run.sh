#!/bin/bash

COMMIT=`git log --pretty=format:'%h' -n 1`

mkdir -p {out/resources,out/matches}

for FILE in apps/*; do
  arrFILE=(${FILE//\// })
  arrFILENAME=(${arrFILE[1]//\./ })
  APP_NAME=${arrFILENAME[0]}

  ./design-as-code -app=$FILE -patternlib=patterns/vmc.hcl -mode=describe -json=out/resources/$COMMIT-$APP_NAME-describe.json
  ./design-as-code -app=$FILE -patternlib=patterns/vmc.hcl -mode=match -json=out/matches/$COMMIT-$APP_NAME-matches.json

done