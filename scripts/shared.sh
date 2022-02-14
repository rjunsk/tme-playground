#!/bin/bash

# Set the current git default branch as DEFAULT_BRANCH
set_default_branch() {
  DEFAULT_BRANCH=$(git remote show origin | grep HEAD | cut -d ":" -f2- | xargs)
}

# Extract the version from a tag by removing the extension prefix plus a hyphen 
# delimiter and set as TAG_VERSION.
set_tag_version () {
  EXTENSION=$1
  TAG_VERSION=${CIRCLE_TAG:${#EXTENSION} + 1}
}