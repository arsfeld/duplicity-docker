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

    docker run --rm=true -v $HOME:/home/dummy:ro -v /run/media:/run/media \
        -v /home/dummy/.cache/duplicity:/home/dummy/.cache/duplicity
        -h duplicity-local-laptop -u `id -u dummy`  kartoch/duplicity:latest 
        full /home/dummy/  file:///run/media/dummy/usb-disk --no-encryption \ 
        --exclude=/home/dummy/.cache --exclude=/home/dummy/tmp  \
        --archive-dir=/home/dummy/.cache/duplicity --name=duplicity-local-laptop

Remarks / Caveats :

* Home directory is mounted read-only to avoid mistakes, only '.cache/duplicity'
  is kept to avoid metadata synchronisation between backup and host.
* '-u $UID' is set to avoid "accidents" on dummy home, as container uses root rights.
* To avoid source mismatch (check on hostname by duplicity), hostname is set using '-h'
  flag on docker.
* '--archive-dir' duplicity option is needed as '$HOME' is not set in docker container. 
