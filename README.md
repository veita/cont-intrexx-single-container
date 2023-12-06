# Intrexx

Single-container image for Intrexx version 10.16.0, 11.0.0 or higher.

## Services

* SSHD
* Postfix
* PostgreSQL
* Intrexx Solr Service

The installation does not contain any portal.

## Base image

The base image is `localhost/debian-systemd:${SUITE}` where `${SUITE}` is either `bullseye`,
or `bookworm`, or `trixie`.

The base image is provided by the [debian-systemd](https://github.com/veita/cont-debian-systemd)
project.


## Building the container image

```bash
git clone https://github.com/veita/cont-intrexx-single-container.git intrexx-single-container
cd intrexx-single-container
./build-image-xxx.sh
```


## Running the container

Run the container, e.g. with

```bash
podman run --detach --rm --cap-add audit_write,audit_control -p=10022:22 -p=10180-10185:10180-10185 localhost/intrexx-single-container-bookworm
```

`podman ps` reports the exposed ports of the running container:

```
CONTAINER ID  IMAGE                                   COMMAND     CREATED        STATUS            PORTS                                                        NAMES
229f33f0d414  localhost/intrexx-single-container-bookworm  /sbin/init  6 seconds ago  Up 5 seconds ago  0.0.0.0:10022->22/tcp, 0.0.0.0:10180-10182->10180-10182/tcp  intrexx-11.0
```

## Creating new Portals

Login via SSH (root password: `admin`), then execute the portal build script, e.g.
```bash
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 10022 root@localhost
/setup/portal/blank/setup.sh
```

Connect the browser with the portal through the exposed port, e.g. http://localhost:10180/

It is also possible to run Nginx as a frontend web server.
