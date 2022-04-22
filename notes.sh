#!/bin/bash
#
# ------------------------------------------------------------------------------
# notes.sh
# ------------------------------------------------------------------------------
#
# Tyler Wayne © 2022
#

THIS_PROG=$( basename $0 )
USAGE="Usage: $THIS_PROG note [...]"

HELP="\
$USAGE
Edit notes

Options:
  -h, --help                Print this help.
"

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
    h)  echo "$HELP"; exit 0 ;;
    \?) echo "$THIS_PROG: unrecognized option '-$OPTARG'" >&2
        echo "Try '$THIS_PROG --help' for more information."
        exit 2 ;;
  esac
done
shift $((OPTIND-1))


notes_dir=${NOTES_DIR:-$HOME/docs/notes/}

args=($@) # Accept a list of notes
notes=(${args[@]/#/$notes_dir})
notes=${notes[@]/%/.txt}

# Assertions -------------------------------------------------------------------

if [ $# -lt 1 ]; then
  echo $USAGE
  exit 1
fi

# Main -------------------------------------------------------------------------

vim $notes # Create a new note if one isn't found
