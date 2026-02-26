#!/bin/bash

BASE_BRANCH="master"

# If argument not provided, ask for input
if [ -z "$1" ]; then
  read -p "Enter feature name: " FEATURE
else
  FEATURE=$1
fi

# Validate again after input
if [ -z "$FEATURE" ]; then
  echo "❌ Feature name cannot be empty."
  # exit 1
  return;
fi

echo "Creating feature branch: $FEATURE"

# Switch to base branch
if ! git checkout "$BASE_BRANCH"; then
  echo "❌ Failed to checkout base branch: $BASE_BRANCH"
  echo "👉 Please ensure the branch exists and you have no pending conflicts."
  # exit 1
  return;
fi

# Pull latest changes
if ! git pull; then
  echo "❌ Failed to pull latest changes from $BASE_BRANCH"
  echo "👉 Please check your network connection or resolve merge issues."
  # exit 1
  return;
fi

# Create feature branch
if ! git checkout -b "$FEATURE"; then
  echo "❌ Failed to create branch: $FEATURE"
  echo "👉 The branch may already exist."
  # exit 1
  return;
fi

# Push to origin
if ! git push -u origin "$FEATURE"; then
  echo "❌ Failed to push branch to remote."
  echo "👉 Please check your remote configuration or permissions."
  # exit 1
  return;
fi

echo "✅ Branch created and pushed."
echo "👉 Start coding. PR will be created after first commit."