#!/bin/bash

echo -e "===\n>> Pre-push Hook: Checking branch name..."

BRANCH=`git rev-parse --abbrev-ref HEAD`
PROTECTED_BRANCHES="^(main|prod)"

# if [[ $1 != *"$BRANCH"* ]]
# then
#   echo -e "\n🚫 You must use (git push origin $BRANCH).\n" && exit 1
# fi

if [[ "$BRANCH" =~ $PROTECTED_BRANCHES ]]
then
  echo -e "\n🚫 Cannot push to remote $BRANCH branch, please create your own branch and use PR.\n===" >&2 && exit 1
fi

echo -e ">> Finish checking branch name.\n==="

exit 0