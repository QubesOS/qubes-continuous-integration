FROM gentoo/stage3:latest

## TODO
# - add notset(?) gentoo mirror keys
# - add notset(?) gentoo repositories
# - add package use (see https://github.com/QubesOS/qubes-builder-gentoo/blob/main/prepare-chroot-base#L149)
# - install packages (see https://github.com/QubesOS/qubes-builder-gentoo/blob/main/prepare-chroot-base#L154)

# ArchLinux example as a reference:
# RUN pacman-key --init && pacman-key --populate && pacman -Syu --noconfirm wget sudo
# RUN wget -O /tmp/qubes-repo-archlinux-key.asc https://raw.githubusercontent.com/QubesOS/qubes-builderv2/main/qubesbuilder/plugins/chroot_archlinux/keys/qubes-repo-archlinux-key.asc
# RUN pacman-key --add - < /tmp/qubes-repo-archlinux-key.asc
# RUN pacman-key --lsign "$(gpg --with-colons --show-key /tmp/qubes-repo-archlinux-key.asc -| grep ^fpr: | cut -d : -f 10)"
# 
# RUN printf '\
# [qubes-r4.2-current-testing]\n\
# Server = https://archlinux.qubes-os.org/r4.2/current-testing/vm/archlinux/pkgs\n\
# [qubes-r4.2-current]\n\
# Server = https://archlinux.qubes-os.org/r4.2/current/vm/archlinux/pkgs\n\
# '\ >> /etc/pacman.conf
# 
# RUN wget -O /usr/local/bin/faketime https://raw.githubusercontent.com/rustybird/realfaketime/main/faketime
# 
# RUN useradd -m user
