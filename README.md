
On your local compter, even if this is x86, you can execute the Docker
container to try things out with:

```sh
docker run -it iox-aarch64-scp-ftp /bin/bash
```

Note that it works because we have embedded qemu in the image, which means
if the container runs on an ARM platform the binaries are executed directly,
while if we run it on x86 then ARM will be automatically emulated by QEMU.


