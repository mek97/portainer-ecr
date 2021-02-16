#!/bin/sh
echo "Content-type: text/html"
echo ""
eval "$(echo "$QUERY_STRING"|awk -F'&' '{for(i=1;i<=NF;i++){print $i}}')"
# shellcheck disable=SC2154
docker_pull_response=$(/docker pull "$REGISTORY_URL""$tag" 2>&1)
echo "$docker_pull_response"
