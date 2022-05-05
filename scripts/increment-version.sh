#!/bin/bash
source $(dirname $0)/shared.sh
set_default_branch
EXTENSION=$1

git checkout $DEFAULT_BRANCH
git pull origin $DEFAULT_BRANCH
VERSION=$(node -pe "require('$EXTENSION/package.json').version")

# Reset RC version to 1 
echo "`jq ".versionRc=1" $EXTENSION/package.json`" > $EXTENSION/package.json

# Increment the prerelease version or patch
if [[ "$VERSION" == *"test"* ]] || [[ "$VERSION" == *"beta"* ]]; then
  npm version --workspace $EXTENSION prerelease
else
  npm version --workspace $EXTENSION patch 
fi

# Push the updated versions to the default branch
git add $EXTENSION/package.json
git commit -m "Increment $EXTENSION versions [skip ci]"
git push origin $DEFAULT_BRANCH