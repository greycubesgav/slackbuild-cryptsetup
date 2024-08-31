FROM greycubesgav/slackware-docker-base:latest AS builder

# Set our prepended build artifact tag and build dir
ENV TAG='_GG' BUILD='1_GG'

#--------------------------------------------------------------
# Cryptsetup Install
#--------------------------------------------------------------
# We need a version of cryptsetup to build tpm2-tss against
# Here we pull a specific version from the official repository
# which matches the version shipped with Unraid version 6.12.11
ARG CRYPTSETUP_VERSION=cryptsetup-2.6.1.tar.xz

#--------------------------------------------------------------
# BuilD Slackware Package
#--------------------------------------------------------------
# Copy over the build files
COPY LICENSE *.info *.SlackBuild README slack-desc /root/build/

# Grab the source and check the md5
WORKDIR /root/build/
COPY ./src/${CRYPTSETUP_VERSION} /root/build/
#RUN wget --no-check-certificate $(sed -n 's/DOWNLOAD="\(.*\)"/\1/p' *.info)cat
RUN export pkgname=$(grep 'DOWNLOAD=' *.info| sed 's|.*/||;s|"||g') \
&& export pkgmd5sum=$(sed -n 's/MD5SUM="\(.*\)"/\1/p' *.info) \
&& echo "$pkgmd5sum  $pkgname" > "${pkgname}.md5" \
&& md5sum -c "${pkgname}.md5"

# Build the package
RUN ./*.SlackBuild

ENTRYPOINT [ "bash" ]

# Create a clean image with only the artifact
FROM scratch AS artifact
COPY --from=builder /tmp/*.txz .
