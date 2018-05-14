# Sub shell

What does create a shell implies?

In which case is this relevant?

Bash creates subshells, by forking the current environment at run time, this means
that the sub-shell inherits all the variables even `$$` (PID of the original
process). The reason is that for a sub-shell, the shell just forks and does not
execute a new shell.

In linux forking is a special case of the `clone` system call.
Here are some of the commands which create a subshell.
* `$()` or `\`\``: Command substitution: creates a sub-shell with its stdout
     set to a pipe and collects the output in the parent and expands that 
     output minus trailing new lines.
* `()`: Grouping, does nothing but wait for a sub-shell and wait for it to 
    terminate, in contrast to `{}` which groups only syntaxtically not by
    creating a sub-shell.
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


## Is a sub-shell the same as a child-shell?

A sub-shell duplicates the existing shell, it has the same vars even the same PID
but not the shell specific variables like `BASHPID`. 
The main diference is that a sub-shell does not call `execve` which is the call
that replaces the environment variables.
