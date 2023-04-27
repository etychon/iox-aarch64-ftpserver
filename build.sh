

VVER="`yq -r .info.version package.yaml | sed "s/\./_/"`"

echo $VVER

docker build -t iox-aarch64-ftpserver .
ioxclient docker package iox-aarch64-ftpserver . --name iox-aarch64-ftpserver_v$VVER.tar
