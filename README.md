## Cross-Compling server using podman

Get Dockerfile, init.sh and patches folder from this repo, put into the same directory.
Or download archive zip with [compressed branch](https://github.com/Tokariew/tomenet/archive/refs/heads/podman.zip)
and uncompress it.

Run this command to create podman image

```
podman build --tag tomenet-server-builder -f Dockerfile --build-arg CACHEBUST=$(date +%s)
```

Compile the server with

```
podman run --rm -v "PATH-WHERE-TO-SAVE-BUILD-SERVER:/srv/build:z" localhost/tomenet-server-builder
```

You should change **PATH-WHERE-TO-SAVE-BUILD-SERVER** with proper path, in mine case it is **/home/tokariew/tomenet**

Folder must exist before running above command, relative path should be proceed with dot or dots

Instead of podman, docker can be used… but it require root privileges.

Server is build on fedora 34, it will create archive with all files which are
needed to run server.

Server will be based on latest commit in official repo

## Patching

On 2021-05-18 I added simple ability to apply custom patches to server. For now
I added simple patch which move IDDC to the same location as official server.

To apply patch add name of file at the end of command example command earlier
like so:

```
podman run --rm -v "out:/srv/build:z" localhost/tomenet-server-builder iddcmove.patch 
```

You can generate your own patch file with git diff like so, if you didn't make
commit:

```
git diff --oneline > patchname.patch
```

Copy generated patch file to patches folder.
