# `root` vs `kernel` modes

When a programm runs with `sudo` 

### `root` mode

The sudo mode is simply giving a command the permissions for root, ie user id 0.
The command ís still uses virtual memory. User mode programs may only access 
memory that is mapped to the running process and they are blocked from any direct
HW access. 


### `kernel` mode 

Kernel mode is realted to cpu modes, the privileged or supervisor mode where all
machine instructions are possible. These instructions include configuring the
MMU, disabling interrupts, halting the machine, doing physical IO. 
The CPU also has the user mode, which is unable to run those instructions

## Differences 

The user root can access the complete file system and also can listen/open ports
below the 1024. Applications, even commands runned as root, are executing in
user mode, and interacting with the linux kernel through system calls, this is
the only way for an application to interact with the kernel. Application code
sees a Virtual Machine capable of doing syscalls and executing user mode
instructions.

## CPU Modes

The cpu modes are part of the architecture of some CPUs that place restrictions
on the type and scope of operations that can be performed by certain processes
being run by the CPU. 

In kernel/supervisor mode, the CPU may perform any operation allowed by its 
architecture; any instruction may be executed, and IO operation initiated, any
memory area accessed, and so on.

Ideally only kernel code is allowed to execute in the unrestricted mode; 
everything else, including part of the kernel, runs in a restricted mode
and must use a system call to request the kernel to perform the action on
its behalf. 
