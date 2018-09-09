# Ansible playbooks

## Requirements for running ansible

Automation framework written in python, python 3 for ansible is being developed, but is already stable.
Ansible is mainly developed in 2.7.

Ansible can be installed with PIP, dnf, yum or using the Activestate. It's possible to use virtual environments
and PIP to install several versions of ansible.

The better option for installing ansible is PIP, works well with virtual enviroments. Virutal environments separeta the working environments
from the main system installation of python, virtual environments can be created by non-root users.

## Environment Set-up

dnsmasq: Acts as a dns server for all the other nodes.

install Ansible in linux:

It's possible to install with apt/yum but they are normally in a old version, the option is to install the provided pkg from the 
official ansible repository `ppa:ansible/ansible` next `apt-get install ansible`. 


To install Ansible with virtual environment, install the python dependencies 

* python-minimal
* virtualenv
* python-dev
* build-essential

Ansible needs a control host and several workers.

```
mkdir ansible
cd ansible 
virtualenv venv27
source venv27/bin/activate
# to test that the environment is active 
which python
```

The python path should be in relation to the environment and not the system installation of python.
Now with the environment activated we can proceed to install ansible, which will be also in relation to the environment.

```
pip install ansible
which ansible
ansible --version
```

For install ansible from git, with the environment activated:

```
pip install git+https://github.com/ansible/ansible
```

This installs the most current ansible release.



## Validating ansible installation

Check that the ansible installation works as expected.

#### Validating ansible installation


#### The ansible configuration file

#### Setting up remote connectivity

#### Configuring remote connectivity in Ansible

#### Congirming conneectivity through the ping module



