## Cross-Compling server using podman

Get Dockerfile, init.sh and fedora.patch from this repo, put into the same directory.
Or download archive zip with [compressed branch](https://github.com/Tokariew/tomenet/archive/refs/heads/podman.zip)
and uncompress it.

Run this command to create podman image

```
podman build --tag tomenet-server-builder -f Dockerfile --build-arg CACHEBUST=$(date +%s)
```

Compile the server with

```
podman run --rm -v "PATH-WHERE-TO-SAVE-BUILD-SERVER:/srv/build" localhost/tomenet-server-builder
```

You should change **PATH-WHERE-TO-SAVE-BUILD-SERVER** with proper path, in mine case it is **/home/tokariew/tomenet**

Folder must exist before running above command, relative path should be proceed with dot or dots

Server is build on fedora 34, it will create archive with all files which are
needed to run server.

Server will be based on latest commit in official repo
