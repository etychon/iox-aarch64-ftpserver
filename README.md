# IOx-based FTP server for Cisco ARM-based devices like IR1101 and IR1800

## Goal

This is a Docker-based IOx application with the only purpose to provide a working FTP server. By deploying this application on a Cisco switch of gateway, you basically run an FTP server that can be used to upload and download files. 

Files are stored in the application local Docker storage space and is not persistent, so all is lost when the application is uninstalled.

## Prerequisites

You'll need a Linux build machine with docker, ioxclient, git, yq, etc...

## How to build

```sh
git clone https://github.com/etychon/iox-aarch64-ftpserver.git
cd iox-aarch64-ftpserver
sh ./build.sh
```

You should have a file called `iox-aarch64-ftpserver_v1_6.tar` ready to use. 

## Try locally

On your local compter, even if this is x86, you can execute the Docker
container to try things out with:

```sh
docker run -it iox-aarch64-ftpserver
```

Note that it works because we have embedded qemu in the image, which means
if the container runs on an ARM platform the binaries are executed directly,
while if we run it on x86 then ARM will be automatically emulated by QEMU.

## Try on IOS

Install the IOx application with the method of your choice: CLI, Local Manager, ioxclient, IoT Operations Dashbaord, FND, etc...

Once the application runs it listens on port TCP/21 and uses TCP/20 for data. Not that you must use passive mode.

