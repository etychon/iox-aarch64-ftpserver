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

## Connecting to FTP server

IOx app will run using an IP address distributed from a DHCP pool configured in IOS (please check Cisco IOS documentation to do that!).

Depending on the configuration you may have to NAT that application IP address to a global IP address using NAT, for instance:

````sh
ip nat inside source static tcp <iox_ip> 21 interface gigabitEthernet 0/0/0 2121
````

You can then connect using user "cisco" and password "cisco" on the gigabitEthernet 0/0/0 IP address on TCP port 2121:

````sh
[etychon@squeeze ~ ]$ ftp -P 2121 192.168.2.163
Connected to 192.168.2.163.
220 ProFTPD Server (ProFTPD Default Installation) [10.8.72.84]
Name (192.168.2.163:etychon): cisco
331 Password required for cisco
Password:
230 User cisco logged in
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> ls -al
229 Entering Extended Passive Mode (|||12522|)
ftp: Can't connect to `192.168.2.163:12522': Connection refused
200 EPRT command successful
150 Opening ASCII mode data connection for file list
drwxr-sr-x   2 cisco    cisco        4096 Apr 27 12:19 .
drwxr-xr-x   1 root     root         4096 Apr 27 12:19 ..
226 Transfer complete
ftp> put edge_app_1219.tar
local: edge_app_1219.tar remote: edge_app_1219.tar
200 EPRT command successful
150 Opening BINARY mode data connection for edge_app_1219.tar
100% |******************************************************************************************************************************************************************************************************|   124 MiB   33.12 MiB/s    00:00 ETA
226 Transfer complete
130039296 bytes sent in 00:03 (33.08 MiB/s)
ftp> quit
221 Goodbye.
````

You can change the login and credentials by editing the Dockerfile, which is highly recommended for real deployments.
