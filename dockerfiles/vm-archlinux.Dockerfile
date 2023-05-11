from archlinux:latest

RUN pacman-key --init && pacman-key --populate && pacman -Syu --noconfirm wget sudo
RUN wget -O /tmp/qubes-repo-archlinux-key.asc https://raw.githubusercontent.com/QubesOS/qubes-builderv2/main/qubesbuilder/plugins/chroot_archlinux/keys/qubes-repo-archlinux-key.asc
RUN pacman-key --add - < /tmp/qubes-repo-archlinux-key.asc
RUN pacman-key --lsign "$(gpg --with-colons --show-key /tmp/qubes-repo-archlinux-key.asc -| grep ^fpr: | cut -d : -f 10)"

RUN printf '\
[qubes-r4.2-current-testing]\n\
Server = https://archlinux.qubes-os.org/r4.2/current-testing/vm/archlinux/pkgs\n\
[qubes-r4.2-current]\n\
Server = https://archlinux.qubes-os.org/r4.2/current/vm/archlinux/pkgs\n\
'\ >> /etc/pacman.conf

RUN useradd -m user
