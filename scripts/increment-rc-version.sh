#!/bin/bash

# Setup
source $(dirname $0)/shared.sh
EXTENSION=$1
set_default_branch

# Increment the current RC version
git checkout $DEFAULT_BRANCH
git pull origin $DEFAULT_BRANCH
NEXT_VERSION_RC=$(node -pe "parseInt(require('$EXTENSION/package.json').versionRc) + 1")
echo "`jq ".versionRc=\"$NEXT_VERSION_RC\"" $EXTENSION/package.json`" > $EXTENSION/package.json

# Push the updated RC version to the default branch
git add $EXTENSION/package.json
git commit -m "Bump $EXTENSION rc version [skip ci]"
git push origin $DEFAULT_BRANCH