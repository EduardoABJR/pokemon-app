#!/usr/bin/env sh

set - env

npm run build

cd dist

git init
git add -A
git commint -m 'New Deployment'
git push -f https://github.com/EduardoABJR/pokemon-app.git master:gh-pages

cd -
gi