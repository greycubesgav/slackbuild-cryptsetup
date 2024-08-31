# slackbuild-cryptsetup
Slackware build script for cryptsetup, required by tpm2-tss build

## Application description
Cryptsetup is an open-source utility used to conveniently set up disk encryption based
on the dm-crypt kernel module.

Homepage: https://gitlab.com/cryptsetup/cryptsetup

## Docker Based Build Instructions

The following instructions show how to build this package using the included Dockerfile.

Docker needs to be installed and running before running the make command.

The final artifact will be copied to a new ./pkgs directory

```bash
# Clone the git repo
git clone https://github.com/greycubesgav/slackbuild-cryptsetup
cd slackbuild-cryptsetup
make docker-artifact-build
# Slackware package will be created in ./pkgs
```

## Manual Build Instructions Under Slackware

The following instructs show how to build the package locally under Slackware.

Note: cryptsetup is needed to build

```bash
# Clone the git repo
git clone https://github.com/greycubesgav/slackbuild-cryptsetup
cd slackbuild-cryptsetup
# Grab the url from the .info file and download it
wget $(sed -n 's/DOWNLOAD="\(.*\)"/\1/p' *.info)
./cryptsetup.SlackBuild
# Slackware package will be created in /tmp
```

## Install Instructions

Once the package is built, it can be installed with

```bash
upgradepkg --install-new --reinstall ./pkgs/cryptsetup-*.txz
```