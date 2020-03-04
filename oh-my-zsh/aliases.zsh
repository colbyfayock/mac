alias ip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'

gpo() {
  branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  echo "Pushing $branch to origin"
  git push origin $branch
}

gpb() {
  BRANCH=$1
  BRANCHES_TO_CLEAN=$(git branch --merged=$BRANCH | grep -v $BRANCH)
  echo "Branches that have been merged to develop:"
  echo $BRANCHES_TO_CLEAN
  read -q "REPLY?Remove branches? (y/n)"
  echo ""
  if [ "$REPLY" != "y" ]; then
    echo "Response was not \"y\", aborting..."
    return
  fi
  echo "Removing branches from local"
  for i in `echo $BRANCHES_TO_CLEAN`; do
    git branch -D $i
  done
  echo "Done."
}