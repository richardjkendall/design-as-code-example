#!/bin/bash

curl "https://$QLIK_TENNANT.ap.qlikcloud.com/api/v1/reloads" \
 -X POST \
 -H "Authorization: Bearer $QLIK_TOKEN" \
 -H "Content-type: application/json" \
 -d '{"appId":"4b9f7f56-a485-4806-8a28-744fb43c85f6","partial":false}'