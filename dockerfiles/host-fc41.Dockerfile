FROM quay.io/fedora/fedora:41

RUN dnf -y install sudo ca-certificates wget gnupg dnf-plugins-core

RUN wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-qubes-4.2-primary https://raw.githubusercontent.com/QubesOS/qubes-builderv2/main/qubesbuilder/plugins/chroot_rpm/keys/RPM-GPG-KEY-qubes-4.2-primary
RUN wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-qubes-4.3-primary https://raw.githubusercontent.com/QubesOS/qubes-builderv2/main/qubesbuilder/plugins/chroot_rpm/keys/RPM-GPG-KEY-qubes-4.3-primary
RUN wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-qubes-devel-primary https://raw.githubusercontent.com/QubesOS/qubes-builderv2/main/qubesbuilder/plugins/chroot_rpm/keys/RPM-GPG-KEY-qubes-devel-primary
RUN printf '\
[qubes-current]\n\
name=qubes-host-current\n\
baseurl=https://yum.qubes-os.org/r4.3/current/host/fc41\n\
enabled=1\n\
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-qubes-4.3-primary\n\
gpgcheck=1\n\
repo_gpgcheck = 1\n\
[qubes-current-testing]\n\
name=qubes-host-testing\n\
baseurl=https://yum.qubes-os.org/r4.3/current-testing/host/fc41\n\
enabled=1\n\
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-qubes-4.3-primary\n\
gpgcheck=1\n\
repo_gpgcheck = 1\n\
'\ >> /etc/yum.repos.d/qubes.repo

RUN dnf -y --best update --allowerasing && \
    dnf config-manager setopt qubes-dom0-current-testing.enabled=1 && \
    dnf --exclude=libvirt-daemon-driver-network -y install reprotest && \
    dnf -y clean all

RUN wget -O /usr/local/bin/faketime https://raw.githubusercontent.com/rustybird/realfaketime/main/faketime
RUN chmod +x /usr/local/bin/faketime

RUN useradd -m user
