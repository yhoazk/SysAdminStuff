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
