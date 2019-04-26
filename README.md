## Docker-packer-ansible

This image aims to provide a usable packer image with ansible slipstreamed
inside for easy utilization of the Ansible remote builder

A few notes:

* I've based off the most official Packer image, `hashicorp/packer`
* This is Alpine Linux, which means it is small and weird
* The entrypoint has been reset to the Docker default `/bin/sh/ -c`

#### Example

Given you bind mount a directory `ami_build` which has your packer.json
and related ansible scripts, something like this should work.

```
docker run -v /home/user/ami_build:/build -ti -e AWS_ACCESS_KEY=blah
-e AWS_SECRET_KEY=blah inanimate/packer-ansible "packer build packer.json"
```
