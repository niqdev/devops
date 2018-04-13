# Version Control Systems

## Git

Documentation

* [git - the simple guide](https://rogerdudler.github.io/git-guide)
* [git notes (1)](https://github.com/niqdev/git-notes/blob/master/git-real-1.md)
* [git notes (2)](https://github.com/niqdev/git-notes/blob/master/git-real-2.md)

## Mercurial

Documentation

* [A Guide to Branching in Mercurial](http://stevelosh.com/blog/2009/08/a-guide-to-branching-in-mercurial)

```
# changes since last commit
hg st

# verify current branch
hg branch

# lists all branches
hg branches

# checkout default branch
hg up default

# pull latest changes
hg pull -u

# create new branch
hg branch "branch-name"

# track new file
hg add .

# track new files and untrack removed files
hg addremove

# commit all tracked files
hg commit -m "my-comment"

# commit specific files
hg commit FILE_1 FILE_2 -m "my-comment"

# commit and track/untrack files (i.e. addremove)
hg commit -A -m "my-comment-with-addremove"

# rename last unpushed commit message
hg commit -m "bad-commit-message"
hg commit --amend -m "good-commit-message"

# discard untracked files
hg purge

# discard uncommitted local changes
hg up -C

# discard local uncommitted branch
hg strip "branch-name"

# push commits in all branches
hg push

# push commits in current branch
hg push -b .

# create a new branch and push commits in current branch (first time only)
hg push -b . --new-branch

# lists unpushed commit
hg outgoing

# change head to specific revision
hg up -r 12345

# merge default branch on current branch
hg up default
hg pull -u
hg status
hg up CURRENT-BRANCH
hg merge default
hg diff

# remove all resolved conflicts
rm **/*.orig

# list stashes
hg shelve --list

# stash
hg shelve -n "my-draft"

# unstash
hg unshelve "my-draft"

# revert/undo last unpushed commit
hg strip -r -1 --keep
hg strip --keep --rev .

# solve conflicts manually and then mark it as merged
hg resolve -m FILE-NAME

# lists commits
hg log
hg ls

# pretty log
hg history --graph --limit 10
```
