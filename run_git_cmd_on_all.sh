#!/bin/sh -e

SEARCHDIR="."
GITCMD="status"
TAKEMEHOME=${PWD}

while getopts ":c:d:" optname; do
  case "$optname" in
		"d")
			SEARCHDIR=$OPTARG
			;;
		"c")
			GITCMD=$OPTARG
			;;
    *)
			echo "OOpsie, try again"
			;;
	esac
done

echo "Recusively running (git $GITCMD) on $SEARCHDIR"

for i in `find $TAKEMEHOME/$SEARCHDIR -type d`; do
	if [ -d "$i/.git" ]; then
		echo "Why lookie there, $i is a git repository, executing your command"
		cd $i
		git $GITCMD
	fi
done

# We changed directories a ton, let's get back to where we started
cd $TAKEMEHOME
