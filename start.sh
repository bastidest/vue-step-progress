#!/bin/bash
set -euo pipefail

source ./source.sh

#doc>    _docIndent_
#doc>>   Indents and filters the documentation depeding on the number of
#doc>>   '>' characters used.
function docIndent() {
    DOCTYPE=${1-'[a-zA-Z0-9]*'}

    script=$(cat <<'EOD'
my $dt = $ENV{DOCTYPE};
while(<>) {
    if($_ =~ /^#$dt(>+)/) {
        $_ =~ s/^#$dt//;
        $_ =~ s/^( *)>\s*/$1  / while($_ =~ /^ *>\s*/);
        print $_;
    }
}
EOD
          )

    DOCTYPE="$DOCTYPE" perl -e "$script"
}

#doc>    _docPretty_
#doc>>   Use simple markup to underline headlines.
function docPretty() {
    perl -pne 's/^( *)_(.+)_/\n$1'"$(tput smul)"'$2'"$(tput rmul)"'/'
}

#>     _help_
#>>    Print an overview of all targets.
function help() {
    echo "usage: $0 COMMAND"
    echo ""
    echo "Commands:"
    docIndent "" < "$0" | docPretty
}

#>     _dev_
#>>    Start the development node server
function dev() {
    if [ ! -d node_modules ] ; then
        npm install
    fi
    npm run dev
}

#>     _dev-container_ [COMMAND...]
#>>    Start the development container with the given command. If no
#>>    command is given, the development server is started instead.
function dev_container() {
    local ARGS=("$@")
    if ! ((${#ARGS[@]})); then
        ARGS=("./start.sh" "dev")
    fi
    docker-compose -f docker-compose.dev.yml run --service-ports --rm node ${ARGS[*]}
}

#>     _build_
#>>    Do a production-ready build
function build() {
    docker-compose -f docker-compose.dev.yml run --rm node npm install
    docker-compose -f docker-compose.dev.yml run --rm node npm run build
}

case "${1-}" in
    "help" )
        help;;
    "dev" )
        dev;;
    "dev-container" )
        dev_container "${@:2}" ;;
    "build" )
        build;;
    *)
        if [ -z ${1+x} ]; then
            echo "no command given"
        else
            echo "invalid command '${1-}'"
        fi
        help
        exit 1;;
esac
