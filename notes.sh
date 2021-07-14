#!/bin/bash
#
# ------------------------------------------------------------------------------
# Notes
# ------------------------------------------------------------------------------
#
# Tyler Wayne © 2020
#

CUR_DIR=$( dirname $0 )
THIS_PROG=$( basename $0 )
USAGE="Usage: $THIS_PROG note [...]"

Help() {
  # Function to display help at command line
  echo $USAGE
  echo "Edit notes"
  echo
  echo "Options:"
  echo "  -h, --help                Print this help."
  echo
}

# Arguments --------------------------------------------------------------------

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


NOTES_DIR=${NOTES_DIR:-$HOME/docs/notes/}

ARGS=($@) # Accept a list of notes
NOTES=(${ARGS[@]/#/$NOTES_DIR})
NOTES=${NOTES[@]/%/.txt}

# Assertions -------------------------------------------------------------------

if [ $# -lt 1 ]; then
  echo $USAGE
  exit 1
fi

# Main -------------------------------------------------------------------------

vim $NOTES # Create a new note if one isn't found
