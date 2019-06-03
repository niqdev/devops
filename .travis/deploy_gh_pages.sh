#!/bin/bash

git remote add gh-pages-travis https://${GITHUB_TOKEN}@github.com/niqdev/devops.git
git fetch gh-pages-travis
git fetch gh-pages-travis gh-pages:gh-pages
mkdocs gh-deploy --clean --force --remote-name gh-pages-travis
