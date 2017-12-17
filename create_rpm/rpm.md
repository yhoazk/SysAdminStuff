# RPM (Red Hat Pakage Manager or RPM pakage Manager)

Once an application is done, we need to redistribute the package, in linux is
possible to just drop the software via tarball or another type of archive file
into a linux system. packaging the software as PRM lets you:
* Include metadata with the package (project URL, version number, size etc)
* Add the package to a yum repository so clients can easily find your software.
* Have clients use common linux tools to install remove and manage the SW
* Easily update and deploy new versions of the software, using the same tools.

With the software in hand, most of the work needed to build the RPM involves
creating a SPEC file. Within the SPEC file you can:
* Identify the commands, configuration files, documentation, ando other items.
* Define where components are ultimately installed on the target system.
* Set permissions and ownership of each file.
* Note when your package is independent on the other component being available.
* Tag files as configurations or documentation files
* Have extra commands executed on the target system when the package is
  installed or uninstalled
* Add changelog entries to identify what changes have gone into each version.

## Rebuilding an existing source code package into an RPM

The best way to learn how to create an RPM pkg is to start with an existing
source code package and rebuid it.
1. Get the src package:

```
$ wget ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6Workstation/en/os/SRPMS/tree-1.5.3-2.el6.src.rpm
```
2. Install the source code into a new `rpmbuild` directory.
```
rpm -ihv tree-1.5.3-2.el6.src.rpm
```
The last command will create a directory in `/root`

The `rpmbuild` directory now contains:
```
[root@A rpmbuild] $ tree
.
├── SOURCES
│   ├── tree-1.2-carrot.patch
│   ├── tree-1.2-no-strip.patch
│   ├── tree-1.5.3.tgz
│   ├── tree-no-color-by-default.patch
│   └── tree-preserve-timestamps.patch
└── SPECS
    └── tree.spec
```

3. Edit the SPEC file. This is inside `SPEC/` and add any change just for demo.
4. Build the RPM.
```
# dnf install rpm-build
$ rpmbuild -ba ~/rpmbuild/SPECS/tree.spec
```
This results in a binary RPM and a source RPM in the RPMS and SRPMS sub-directories.
5. Sign the RPM. To sign a RPM a public and private key are needed. Use the
private key to sign the RPM, and then distribute the public key to clients so
they can use the key to check the signed package.

```
gpg --gen-key # generate public/private key
```
The output will be similar to this:
```
pub  2048R/99A9CF07 2011-09-16
Key fingerprint = 90BF B5DC 628E C9E0 88D0 E5D1 E828 4641 99A9 CF07
uid Chris Negus (My own build of the tree package.) <cnegus@redhat.com>
sub 2048R/48E60E56 2011-09-16
```

Use the key ID generated in this case 99A9CF07 to export the public key
```
gpg -a -o RPM-GPG-KEY-ABC --export 99A9CF07
```
To make sure the key ID is used to sign the pkg, add a `_gpg_name` line to the
*.rpmmacros* file in your home directory.
```
$ cat > ~/.rpmmacro
%_gpg_name 99A9CF07
^D
```
Now we are ready to sign the package.

```
rpm --resign ~/rpmbuild/RPMS/x86_64/tree-1.5.3.2.e16.x86_64.rpm
```
Now we are ready to publish the RPM package.
- - -

## Building and RPM from scratch

The SPEC file typically contains instructions on how to build RPM, what files
are part of the package and where it should be installed.

The RPM performs the following tasks during the build process.
1. Executes the commands and macros mentioned in the `prep` section of the SPEC
2. Checks the content of the file list
3. Executes the commands and macros in the build section of the SPEC. Macros from the
 file list is also executed in this step.
4. Creates the binary package file
5. Creates the source package file

Once the RPM executes the above steps, it creates the binary package file and
source package file, this file consists of all soruce files along with the info
rmation to install/uninstall the package.


---
## Having RPM use a different build area.
[src](http://ftp.rpm.org/max-rpm/s1-rpm-anywhere-different-build-area.html)



---

## rpm vs deb
