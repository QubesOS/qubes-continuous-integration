FROM debian:bullseye

RUN apt -y update && DEBIAN_FRONTEND=noninteractive apt -y install sudo ca-certificates wget gnupg reprotest && apt -y clean all

RUN printf '\
deb [arch=amd64 signed-by=/usr/share/keyrings/qubes-archive-keyring-4.2.gpg] https://deb.qubes-os.org/r4.2/vm bullseye main\n\
deb [arch=amd64 signed-by=/usr/share/keyrings/qubes-archive-keyring-4.2.gpg] https://deb.qubes-os.org/r4.2/vm bullseye-testing main\n\
'\ >> /etc/apt/sources.list
RUN wget -O /tmp/qubes-debian-r4.2.asc https://raw.githubusercontent.com/QubesOS/qubes-secpack/main/keys/template-keys/qubes-release-4.2-debian.asc
RUN gpg --dearmor < /tmp/qubes-debian-r4.2.asc > /usr/share/keyrings/qubes-archive-keyring-4.2.gpg
RUN wget -O /tmp/qubes-debian-r4.3.asc https://raw.githubusercontent.com/QubesOS/qubes-secpack/main/keys/template-keys/qubes-release-4.3-debian.asc
RUN gpg --dearmor < /tmp/qubes-debian-r4.3.asc > /usr/share/keyrings/qubes-archive-keyring-4.3.gpg
RUN wget -O /tmp/qubes-debian-rdevel.asc https://raw.githubusercontent.com/QubesOS/qubes-builderv2/main/qubesbuilder/plugins/chroot_deb/keys/qubes-debian-rdevel.asc
RUN gpg --dearmor < /tmp/qubes-debian-rdevel.asc > /usr/share/keyrings/qubes-archive-keyring-devel.gpg

RUN wget -O /usr/local/bin/faketime https://raw.githubusercontent.com/rustybird/realfaketime/main/faketime
RUN chmod +x /usr/local/bin/faketime

# workaround mkinitramfs not seeing root dev in docker
RUN mkdir -p /etc/initramfs-tools/conf.d && echo MODULES=list > /etc/initramfs-tools/conf.d/gitlab-ci.conf

RUN useradd -m user
