# Git snippets and workflow

There are 2 "types" of git repos:
    * `bare`: 
        - This kind of repo does not contain code, it contain all the references and blobs to keep the history. It's intended only to
        be cloned.
        - created with `git init --bare`
    * `non-bare`:
        - This repo is the most common, is the type you get when apply: `git clone`.
        - This repo contains legible code.


## Git branches

### Manage branches

#### Create a branch and change to it.
**Create the branch**: `git branch <branch_name>`<br>
**Change to that branch**: `git checkout <branch_name>` <br>
Or use the short form:
**Create and change to branch**: `git checkout -b <branch_name>`



#### Delete branches from local and remote
**From local**: `git branch -D <branch_name>` <br>
**From remote**: `git push origin --delete <branch_name>`<br>




## Merging

### Setting mergetool:

```
git config --global merge.tool <tool_bin_name>
git config --global mergetool.kdiff3.path '<path>'
```


### Clean after the merge:

The process of merge a file creates several "temporal" files and a
backup named `*.orig`. After a merge is done we can eliminate them with
a built in command:

This command shows which files are to be deleted (dry run):
```
git clean -n
```
This command confirms and executes the deletion:
```
git clean -f
```


### Tools:

#### kdiff3

Kdiff3 helps to make the 3 way merge, it splits the screen in 2 rows.
The first row, contains the 3 files, remote, local, base.
The second row shows the result of the merge.

Kdiff3 works by solving one conflict at a time. If it's not possible 
to solve the conflict automatically, it will ask which portion of the
code is to be used.
To indicate which one (base, local, remote) select it with:


* `ctrl+1`
* `ctrl+2`
* `ctrl+3`


