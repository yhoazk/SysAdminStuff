# Sub shell

What does create a shell implies?

In which case is this relevant?

Bash creates subshells, by forking the current environment at run time, this means
that the sub-shell inherits all the variables even `$$` (PID of the original
process). The reason is that for a sub-shell, the shell just forks and does not
execute a new shell.

Variables in a subshell are not visible outside the block of code in the
subshell. They are not accessible to the parent process, to the shell that
lauched the subshell. These are, in effect, variables local to the child
process.

In linux forking is a special case of the `clone` system call.
Here are some of the commands which create a subshell.
* `$()` or `\`\``: Command substitution: creates a sub-shell with its stdout
     set to a pipe and collects the output in the parent and expands that 
     output minus trailing new lines.
* `()`: Grouping, does nothing but wait for a sub-shell to terminate, in 
       contrast to `{}` which groups only syntaxtically not by creating a 
       sub-shell.
* `&` background. Creates a sub-shell but doesnt wait for its termination.,
* `... | ...`: Pipeline: Creates two sub-shells, one for the left hand and
    one for the right and waits for both to terminate, also creates a pipe
    connecting the stdout of the left-hand to the right-hand process.
* `<(...)`: Process substitution: Creates a subshell with its stdout set to a 
    pipe and expands to the name of the pipe. The parent may open the pipe to 
    communicate with the sub-shell.
* `>(...)`: Does the same as the last one, but with the pipe on the stdout.
* `coproc ...` coprocess: creates a subshell and does not wait for its 
    termination. The subshell std in and out are each set to a pipe with the
    parent being connected to the other end of each pipe.




## Example:
This demostrates the shell specifics, the `BASHPID` is unique to the shell,
then the second number is always the same, but the first changes as is in a
sub-shell.
```
echo $(echo $BASHPID) $BASHPID
```

Bash also exposes a variable to find if we are inside a subshell and at which
level of nesting, use the variable `$BASH_SUBSHELL`, note that there is a
similar varible called `SHLVL` but this one is not affecteb by _sub_shells

Example:
```
echo "\$BASH_SUBSHELL outside subshell = $BASH_SUBSHELL"
    (echo "\$BASH_SUBSHELL first subshell = $BASH_SUBSHELL")
    ( ( echo "\$BASH_SUBSHELL nested 2nd subshell = $BASH_SUBSHELL" ) ) ## remember the spaces between parenthesis or it throwns an error
```


## Is a sub-shell the same as a child-shell?

A sub-shell duplicates the existing shell, it has the same vars even the same PID
but not the shell specific variables like `BASHPID`. 
The main diference is that a sub-shell does not call `execve` which is the call
that replaces the environment variables.


## How to get the exit status of a subshell?

The variable `$?` gets set after the subshell.

Eg:
```sh
(exit noname_var); echo $?
```
