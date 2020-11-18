## Cross-Compling server using podman

Get Dockerfile and init.sh from this repo, put into the same directory.
Run this command to create podman image

```
podman build --tag tomenet-server-builder -f Dockerfile
```

Compile the server with

```
podman run --rm -v "PATH-WHERE-TO-SAVE-BUILD-SERVER:/srv/build" localhost/tomenet-server-builder
```

You should change **PATH-WHERE-TO-SAVE-BUILD-SERVER** with proper path, in mine case it is **/home/tokariew/tomenet**

Server is build on fedora 32 – Fedora 33 have currently some problems with linking libraries.

Server will be based on latest commit in official repo
