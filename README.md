# Duplicity by Docker

This is a docker image with latest release from 0.7 series of duplicity. 

## Protocols Supported

* local copy (file://)
* hubic (cf+hubic://)

## Exemples

### local copy

Home directory full backup of user 'dummy' to the local USB mounted disk 
located in '/run/media/dummy/usb-disk' with no encryption support with exclusion
of some directories

    docker run --rm=true -v $HOME:/home/dummy -v /run/media:/run/media \
        kartoch/duplicity:latest full /home/dummy/  \
        file:///run/media/dummy/usb-disk --no-encryption \ 
        --exclude=/home/dummy/.cache --exclude=/home/dummy/tmp  \
        --exclude=/home/dummy/virtua --exclude=/home/dummy/opt \
        --exclude=/home/dummy/.config/duplicity/ --allow-source-mismatch

Remarks / Caveats :

* '--allow-source-mismatch' is needed to avoid duplicity error as the hostname
is changed between each docker run. Another way is to use the '--hostname' flag of
docker to set the same hostname for every docker run.
* The duplicity cache is not keep between each run, a new one is generated from the
backup at each run, as user 'root' is used inside the docker container. I didn't found
a way to set the '$HOME' inside the container at startup.