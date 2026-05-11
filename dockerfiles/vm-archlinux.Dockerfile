FROM archlinux:latest

RUN pacman-key --init && pacman-key --populate && pacman -Syu --noconfirm --noprogressbar wget sudo
RUN wget -O /tmp/qubes-repo-archlinux-key.asc https://raw.githubusercontent.com/QubesOS/qubes-secpack/main/keys/template-keys/qubes-release-4.2-archlinux.asc
RUN pacman-key --add - < /tmp/qubes-repo-archlinux-key.asc
RUN pacman-key --lsign "$(gpg --with-colons --show-key /tmp/qubes-repo-archlinux-key.asc -| grep ^fpr: | cut -d : -f 10)"
RUN wget -O /tmp/qubes-repo-archlinux-key.asc https://raw.githubusercontent.com/QubesOS/qubes-secpack/main/keys/template-keys/qubes-release-4.3-archlinux.asc
RUN pacman-key --add - < /tmp/qubes-repo-archlinux-key.asc
RUN pacman-key --lsign "$(gpg --with-colons --show-key /tmp/qubes-repo-archlinux-key.asc -| grep ^fpr: | cut -d : -f 10)"
RUN wget -O /tmp/qubes-repo-archlinux-key.asc https://raw.githubusercontent.com/QubesOS/qubes-builderv2/main/qubesbuilder/plugins/chroot_archlinux/keys/qubes-repo-archlinux-key-rdevel.asc
RUN pacman-key --add - < /tmp/qubes-repo-archlinux-key.asc
RUN pacman-key --lsign "$(gpg --with-colons --show-key /tmp/qubes-repo-archlinux-key.asc -| grep ^fpr: | cut -d : -f 10)"

RUN printf '\
[qubes-r4.2-current-testing]\n\
Server = https://archlinux.qubes-os.org/r4.2/current-testing/vm/archlinux/pkgs\n\
[qubes-r4.2-current]\n\
Server = https://archlinux.qubes-os.org/r4.2/current/vm/archlinux/pkgs\n\
'\ >> /etc/pacman.conf

RUN wget -O /usr/local/bin/faketime https://raw.githubusercontent.com/rustybird/realfaketime/main/faketime
RUN chmod +x /usr/local/bin/faketime

RUN useradd -m user
