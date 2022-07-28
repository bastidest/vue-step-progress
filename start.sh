#!/bin/bash
set -eo pipefail

source ./source.sh

function dev() {
    if [ ! -d node_modules ] ; then
        _npm install
    fi
    docker-compose -f docker-compose.dev.yml run --service-ports --rm node npm run dev
}

function build() {
    if [ "$(id -u)" == "0" ] ; then
        echo 'warning: trying to build as root user, falling back to user 1000'
        export DOCKER_USER='1000:1000'
    fi
    if [ "$(id -u)" == "1001" ] && [ "$(id -g)" == "121" ] ; then
        echo 'warning: trying to build as CI user, falling back to user 1000'
        export DOCKER_USER='1000:1000'
    fi
    docker-compose -f docker-compose.dev.yml run --rm node rm -rf node_modules
    docker-compose -f docker-compose.dev.yml run --rm node npm install
    docker-compose -f docker-compose.dev.yml run --rm node npm run build
}

case "${1-}" in
    "dev" )
        dev;;
    "build" )
        build;;
    "release" )
        if [[ ! -f .npmrc ]] ; then
            echo "no .npmrc file exists, please create it (//registry.npmjs.org/:_authToken=<token>)"
            exit 1
        fi

        if ! _npm whoami ; then
            echo "you need to be logged into the npm registry before creating a release"
            exit 1
        fi

        if [[ -n "$2" ]] ; then
            VERSION="$2"
        else
            VERSION=$(git-conventional-commits version)
        fi
        echo "-- creating release for version ${VERSION}"

        echo "-- patching package{,-lock}.json"
        jq ".version=\"${VERSION}\"" package.json > package.json.tmp && mv package.json.tmp package.json
        _npm i >/dev/null

        echo "-- building release artifacts"
        build

        echo "-- creating release commit"
        git commit -am"build(release): bump project version to ${VERSION}"

        echo "-- creating changelog"
        git-conventional-commits changelog --release "$VERSION" --file CHANGELOG.MD

        read -r -p "-- changelog ok? [Y/n]" response
        response=${response,,} # tolower
        if [[ $response =~ ^(no|n) ]] ; then
            echo "aborting"
            exit 1
        fi

        echo "-- creating commit for changelog"
        git commit -am"doc(release): create ${VERSION} change log entry"

        echo "-- tagging version"
        git tag -a -m"build(release): ${VERSION}" "v${VERSION}"

        read -r -p "-- git push? [Y/n]" response
        response=${response,,} # tolower
        if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
            git push --atomic origin master "v${VERSION}"
        fi

        read -r -p "-- npm publish? [Y/n]" response
        response=${response,,} # tolower
        if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
            _npm publish
        fi

        echo "-- RELEASE DONE"
        ;;

    *)
        if [ -z ${1+x} ]; then
            echo "no command given"
        else
            echo "invalid command '${1-}'"
        fi
        exit 1;;
esac
