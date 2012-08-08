#!/bin/sh -e

SEARCHDIR=${PWD}
GITCMD="status"
TAKEMEHOME=${PWD}
REPOSFOUND=0

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

for i in `find $SEARCHDIR -type d`; do
	if [ -d "$i/.git" ]; then
		let "REPOSFOUND = $REPOSFOUND + 1"
		echo "Why lookie there, $i is a git repository, executing your command"
		cd $i
		git $GITCMD
	fi
done

echo "Found $REPOSFOUND git repositories and ran your command on all of them"

# We changed directories a ton, let's get back to where we started
cd $TAKEMEHOME
