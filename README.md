# Nexus playground

This is a small set of scripts that will help you create a sandbox Sonatype Nexus 3
environment to play with.

The Nexus will be launched inside a Vagrant box, to isolate it from your host.

:warning: Please do not run the shell scripts outside of the Vagrant machine, unless you
understand what they do.

# Quickstart

Launch the Vagrant box:
```
vagrant up
```
That's it! The Nexus will be available under http://localhost:8080 from your host
(the port is configured to be forwarded by Vagrant).

**The login and password are both `admin`.**

If you'd like to reset Nexus to it's initial state, please run:
```
vagrant provision --provision-with nexus
```
