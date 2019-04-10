#!/usr/bin/env bash

echo "EXIT: Untested"
exit 1

# === CREATE A README.md / FIRST COMMIT ===
touch README.md
echo "# Project" > README.md
git add README.md

git commit -m "Initial Commit"
git push

# === CREATE A BASE TAG ===
git tag -a v0.0.0 -m "Initial Version"
git push --tags

# === GIT FLOW INIT / CREATE DEVELOP ===
git flow init -d
git checkout develop
git push --set-upstream origin develop
