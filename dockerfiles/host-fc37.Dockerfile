FROM quay.io/fedora/fedora:37
RUN dnf -y update && dnf -y install sudo ca-certificates wget gnupg dnf-plugins-core reprotest && dnf -y clean all
RUN wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-qubes-4.2-primary https://raw.githubusercontent.com/QubesOS/qubes-builderv2/main/qubesbuilder/plugins/chroot_rpm/keys/RPM-GPG-KEY-qubes-4.2-primary
RUN printf '\
[qubes-current]\n\
name=qubes-host-current\n\
baseurl=https://yum.qubes-os.org/r4.2/current/host/fc37\n\
enabled=1\n\
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-qubes-4.2-primary\n\
gpgcheck=1\n\
repo_gpgcheck = 1\n\
[qubes-current-testing]\n\
name=qubes-host-testing\n\
baseurl=https://yum.qubes-os.org/r4.2/current-testing/host/fc37\n\
enabled=1\n\
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-qubes-4.2-primary\n\
gpgcheck=1\n\
repo_gpgcheck = 1\n\
'\ >> /etc/yum.repos.d/qubes.repo
RUN useradd -m user
