#!/bin/sh

git reset $(git commit-tree HEAD^{tree} -m "init")
