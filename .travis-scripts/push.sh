#!/bin/sh

set -x

setup_git() {
  git config credential.helper 'cache --timeout=120'
  git config --global user.email "rbroker@xebialabs.com"
  git config --global user.name "Travis CI"
}

commit_website_files() {
  #git checkout -b master
  git add . *.html
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
#  git remote add origin-pages https://${TRAVIS_PUSH}@github.com/zvercodebender/xebialabs-community.github.io.git > /dev/null 2>&1
  git remote add origin https://${TRAVIS_PUSH}@github.com/zvercodebender/xebialabs-community.github.io.git > /dev/null 2>&1
  #git remote add origin https://oauth2:${GH_TOKEN}@github.com/zvercodebender/xebialabs-community.github.io.git
  git push origin HEAD:master
  #git push https://${TRAVIS_PUSH}@github.com/zvercodebender/xebialabs-community.github.io master
}

setup_git
commit_website_files
upload_files
