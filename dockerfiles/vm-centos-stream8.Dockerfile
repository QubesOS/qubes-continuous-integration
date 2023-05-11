FROM quay.io/centos/centos:stream8
RUN dnf -y update && dnf -y install sudo ca-certificates wget gnupg && dnf -y clean all
RUN wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-qubes-4.2-centos https://raw.githubusercontent.com/QubesOS/qubes-builderv2/main/qubesbuilder/plugins/chroot_rpm/keys/RPM-GPG-KEY-qubes-4.2-centos
RUN wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-copr-epel-8 https://raw.githubusercontent.com/QubesOS/qubes-builderv2/main/qubesbuilder/plugins/chroot_rpm/keys/RPM-GPG-KEY-copr-epel-8
RUN printf '\
[qubes-current]\n\
name=qubes-vm-current\n\
baseurl=https://yum.qubes-os.org/r4.2/current/vm/centos-stream8\n\
enabled=1\n\
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-qubes-4.2-centos\n\
gpgcheck=1\n\
[qubes-current-testing]\n\
name=qubes-vm-testing\n\
baseurl=https://yum.qubes-os.org/r4.2/current-testing/vm/centos-stream8\n\
enabled=1\n\
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-qubes-4.2-centos\n\
gpgcheck=1\n\
[copr-fepitre-epel-qubes]\n\
name=Copr repo for epel-8-qubes owned by fepitre\n\
baseurl=https://download.copr.fedorainfracloud.org/results/fepitre/epel-$releasever-qubes/epel-8-x86_64/\n\
enabled=0\n\
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-copr-epel-8\n\
gpgcheck=1\n\
'\ >> /etc/yum.repos.d/qubes.repo
RUN useradd -m user
