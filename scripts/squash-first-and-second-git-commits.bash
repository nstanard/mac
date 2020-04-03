#!/bin/sh

# You give it two commit SHA1s and it will squash everything between them into one commit named "squashed history"

# Go back to the last commit that we want
# to form the initial commit (detach HEAD)
git checkout $2

# reset the branch pointer to the initial commit (= $1),
# but leaving the index and working tree intact.
git reset --soft $1

# amend the initial tree using the tree from $2
git commit --amend -m "squashed history"

# remember the new commit sha1
TARGET=`git rev-list HEAD --max-count=1`

# go back to the original branch (assume master for this example)
git checkout master

# Replay all the commits after $2 onto the new initial commit
git rebase --onto $TARGET $2

# Change Commit
# git commit --amend -m "squashed history"

# Change Author
# git commit --amend --author="Neal Stanard <nstanard@gmail.com>" --no-edit
