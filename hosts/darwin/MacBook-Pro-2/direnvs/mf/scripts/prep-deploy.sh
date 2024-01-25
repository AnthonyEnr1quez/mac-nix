#!/usr/bin/env bash

service_name=$(basename -s .git `git config --get remote.origin.url`)
echo $service_name

latest_tag=$(git describe --tags --abbrev=0)
echo $latest_tag

publish_release_run_id=$(gh run list --json workflowName,databaseId,headBranch | jq --arg tag "$latest_tag" '.[] | select(.headBranch == $tag).databaseId')
echo $publish_release_run_id

publish_release_run_status=$(gh run view $publish_release_run_id --json status --jq '.status')
echo $publish_release_run_status

if [ $publish_release_run_status != "completed" ] ; then
  echo "Publish Release run currently in $publish_release_run_status status"
  exit
fi

# get pdev pr
pdev_pr_json=$(gh pr list -R moovfinancial/platform-dev -A "moov-bot" --json title,number,url | jq --arg tag "$latest_tag" --arg service_name "$service_name" '.[] | select(.title | contains ($tag) and contains ($service_name))')
echo $pdev_pr_json

# get infra prs
staging_pr_json=$(gh pr list -R moovfinancial/infra -A "moov-bot" --json title,number,url | jq --arg tag "$latest_tag" --arg service_name "$service_name" '.[] | select(.title | contains ($tag) and contains ($service_name) and contains ("staging"))')
echo $staging_pr_json

production_pr_json=$(gh pr list -R moovfinancial/infra -A "moov-bot" --json title,number,url | jq --arg tag "$latest_tag" --arg service_name "$service_name" '.[] | select(.title | contains ($tag) and contains ($service_name) and contains ("production"))')
echo $production_pr_json

# mark the prs ready and tag platform cards as reviewer
# TODO enable these
pdev_pr_number=$(jq -r '.number' <<< "$pdev_pr_json")
echo $pdev_pr_number
# gh pr edit -R moovfinancial/platform-dev $pdev_pr_number --add-reviewer moovfinancial/platform-cards
# gh pr ready -R moovfinancial/platform-dev $pdev_pr_number

staging_pr_number=$(jq -r '.number' <<< "$staging_pr_json")
echo $staging_pr_number
# gh pr edit -R moovfinancial/infra $staging_pr_number --add-reviewer moovfinancial/platform-cards
# gh pr ready -R moovfinancial/infra $staging_pr_number

production_pr_number=$(jq -r '.number' <<< "$production_pr_json")
echo $production_pr_number
# gh pr edit -R moovfinancial/infra $production_pr_number --add-reviewer moovfinancial/platform-cards
# gh pr ready -R moovfinancial/infra $production_pr_number

# format slack message
pdev_pr_url=$(jq -r '.url' <<< "$pdev_pr_json")
staging_pr_url=$(jq -r '.url' <<< "$staging_pr_json")
production_pr_url=$(jq -r '.url' <<< "$production_pr_json")

slack_message=":pr: $service_name,
- platform-dev: $pdev_pr_url
- staging: $staging_pr_url
- production: $production_pr_url
"

printf "$slack_message"
