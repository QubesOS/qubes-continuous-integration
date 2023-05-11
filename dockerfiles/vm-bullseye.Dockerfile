from debian:bullseye

RUN apt -y update && apt -y install sudo ca-certificates wget gnupg && apt -y clean all

RUN printf '\
deb [arch=amd64] https://deb.qubes-os.org/r4.2/vm bullseye main\n\
deb [arch=amd64] https://deb.qubes-os.org/r4.2/vm bullseye-testing main\n\
'\ >> /etc/apt/sources.list
RUN wget -O /tmp/qubes-debian-r4.2.asc https://raw.githubusercontent.com/QubesOS/qubes-builderv2/1f51ebdda6f386370ebfa5c600744b8fd2d9d9db/qubesbuilder/plugins/chroot_deb/keys/qubes-debian-r4.2.asc
RUN gpg --dearmor < /tmp/qubes-debian-r4.2.asc > /etc/apt/trusted.gpg.d/qubes-debian-r4.2.gpg

RUN useradd -m user
