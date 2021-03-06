#!/bin/bash

git fetch --tags

git tag -d v1.0.3-build-build 
git push origin :refs/tags/v1.0.3-build-build
git tag -d v1.0.3-build-build-build
git push origin :refs/tags/v1.0.3-build-build-build
git tag -d v1.0.3-build-build-build-build
git push origin :refs/tags/v1.0.3-build-build-build-build
git tag -d v1.0.3-build-build-build-build-build
git push origin :refs/tags/v1.0.3-build-build-build-build-build
git tag -d v1.0.3-build-build-build-build-build-build
git push origin :refs/tags/v1.0.3-build-build-build-build-build-build

LATEST=`cat LATEST`
CURRENT=`git tag --list | grep -v build | sort --version-sort | tail -n 1`

echo "Latest on disk: $LATEST"
echo "Latest in repo: $CURRENT"

if [ "$CURRENT" != "$LATEST" ]
then
  echo "Deploying new build for $CURRENT"
  git config --global user.email "circleci@mail.com" && \
  git config --global user.name "circleci" && \
  rm -Rf site/* && \
  bower update && \
  gulp site && \
  gulp deploy && \
  pushd .publish && \
  git tag ${CURRENT}-build && \
  git push && git push --tags && \
  popd && \
  echo $CURRENT > LATEST && \
  git add LATEST && \
  git commit -m "Updating latest tag" && \
  git push && git push --tags && \
  echo "Pushing fabric8/fabric8-console:${CURRENT} to Docker Hub" && \
  git checkout ${CURRENT} && \
  rm -Rf site/* && \
  bower update && \
  gulp site && \
  docker build -t fabric8/fabric8-console:${CURRENT} . && \
  docker push fabric8/fabric8-console:${CURRENT}
# else
#  echo "Re-tagging new build for ${CURRENT}"
#  docker tag fabric8/fabric8-console fabric8/fabric8-console:${CURRENT}
#  docker push fabric8/fabric8-console:${CURRENT}
fi

