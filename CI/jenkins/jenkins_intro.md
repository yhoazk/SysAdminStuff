# [Jenkins CI](https://jenkins-ci.org)

From the Jenkins GUI(http://localhost:8080/configure) you can install
different versions of Maven, Ant and java. These do not need to be 
installed as a part of the OS.

There are numerous ways to instal jenkins:
- As a windows service
- Using the repository management features apt, yum, dnf
- using java web start
- running it directly from a `WAR` file.

To experiment the best approach is to use the `WAR` file using https
from the command line, pointing to a custom directory.

To use this approach, first set the `JENKINS_HOME` environment variable
to the directory where Jenkis will run. Next, run a command similar to:

```
java -jar jenkins.war -httpsPort=8443 -httpPort=-1
```

With the last command Jenkins will start to run over https on port `8443`.
The http (w/o s) is turned off by setting `httpPort=-1` and the terminal
will display logging info.

For help installing Jenkins execute the command:
```
java -jar jenkins.war -help
```

## Install Jenkins in a Linux machine


For the different `*inx` flavours there is a guide on how to add the jenkins
repository to the package store. Follow the directions in: [`pkg.jenkins-ci.org`.](https://pkg.jenkins-ci.org)

We will follow the Debian steps as most of the people use fkn Ubuntu:
- Add the repository to the system:
```
wget -q -O https://pkg.jenkis.io/debian/jenkins.io.key | sudo apt-key add -
```

Then add the following entry in your `/etc/apt/sources.list`
```
deb https://pkg.jenkins.io/debian binary/
```


*NOTE:* Jenkins does not work with Java 9, then is needed to install JRE 7 or 8.

- Update the locak package index, and finally install jenkins

```
sudo apt-get update
sudo apt-get install jenkins
```

- - -

## For RH nix systems:

This still works in FC-24
```
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https:/pkg.jenkins.io/redhat/jenkins.io.key
```
Now install it:
```
sudo dnf install jenkins
```



