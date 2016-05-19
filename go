#!/usr/bin/env bash

set -e

DEV_IMAGE=dev


function helptext {
    echo "Usage: ./go <command>"
    echo ""
    echo "Available commands are:"
    echo "    start         Start the server"
    echo ""
    echo "    exec          Execute any command inside the dev image"
    echo "    shell         Obtain an interactive terminal on the dev image"
    echo ""
}

function parse_args {
  [[ $@ ]] || { helptext; exit 1; }

  case "$1" in
    help) helptext
      ;;
    exec) cmd $@
      ;;
    sh|shell) shell
      ;;
    start) start
      ;;
    *)
      helptext
      exit 1
  esac
}

function start {
  docker-compose up
}

function cmd {
  shift
  docker-compose run --rm ${DEV_IMAGE} $@
}

function shell {
  docker-compose run --rm --entrypoint bash ${DEV_IMAGE}
}

parse_args "$@"
