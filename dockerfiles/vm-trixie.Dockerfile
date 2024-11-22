FROM debian:trixie

RUN apt -y update && DEBIAN_FRONTEND=noninteractive apt -y install sudo ca-certificates wget gnupg reprotest && apt -y clean all

RUN printf '\
deb [arch=amd64 signed-by=/usr/share/keyrings/qubes-archive-keyring-4.2.gpg] https://deb.qubes-os.org/r4.2/vm trixie main\n\
deb [arch=amd64 signed-by=/usr/share/keyrings/qubes-archive-keyring-4.2.gpg] https://deb.qubes-os.org/r4.2/vm trixie-testing main\n\
'\ >> /etc/apt/sources.list
RUN wget -O /tmp/qubes-debian-r4.2.asc https://raw.githubusercontent.com/QubesOS/qubes-secpack/main/keys/template-keys/qubes-release-4.2-debian.asc
RUN gpg --dearmor < /tmp/qubes-debian-r4.2.asc > /usr/share/keyrings/qubes-archive-keyring-4.2.gpg
RUN wget -O /tmp/qubes-debian-r4.3.asc https://raw.githubusercontent.com/QubesOS/qubes-secpack/main/keys/template-keys/qubes-release-4.3-debian.asc
RUN gpg --dearmor < /tmp/qubes-debian-r4.3.asc > /usr/share/keyrings/qubes-archive-keyring-4.3.gpg

RUN wget -O /usr/local/bin/faketime https://raw.githubusercontent.com/rustybird/realfaketime/main/faketime
RUN chmod +x /usr/local/bin/faketime

RUN useradd -m user
