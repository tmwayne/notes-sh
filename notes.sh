#!/bin/bash
#
# Notes
#
# Tyler Wayne © 2020

CUR_DIR=$( dirname $0 )
THIS_PROG=$( basename $0 )
USAGE="Usage: $THIS_PROG [-e virtual_env] [-p port] [vim_args]"

Help() {
  # Function to display help at command line
  echo $USAGE
  echo "Edit notes"
  echo
  echo "Options:"
  echo "  -h, --help                Print this help."
  echo
}

## ARGUMENTS
########################################

# Command-line arguments
for arg in "$@"; do
  shift
  case "$arg" in
    --help)         set -- "$@" "-h" ;;
    --*)            echo "$THIS_PROG: unrecognized option '$arg'" >&2
                    echo "Try '$THIS_PROG --help' for more information."
                    exit 2 ;;
    *)              set -- "$@" "$arg"
  esac
done

OPTIND=1
while getopts ":h" opt; do
  case $opt in
    h)  Help; exit 0 ;;
    \?) echo "$THIS_PROG: unrecognized option '-$OPTARG'" >&2
        echo "Try '$THIS_PROG --help' for more information."
        exit 2 ;;
  esac
done
shift $((OPTIND-1))


NOTES_DIR=${NOTES_DIR:-/home/tyler/docs/notes/}
NOTE="$NOTES_DIR"/$1.txt

## ASSERTIONS
########################################

if [ $# -lt 1 ]; then
  echo $USAGE
  exit 1
fi

## MAIN
########################################

if [ -f "$NOTE" ]; then
  vim $NOTE
fi
