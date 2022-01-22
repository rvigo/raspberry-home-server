FROM alpine:latest

RUN apk --update --no-cache add \
    bash \
    samba-common-tools \
    samba-client \
    samba-server \
    coreutils \
    shadow \
    && rm -rf /var/cache/apk/*

COPY smb.conf /etc/samba/smb.conf
COPY add_user.sh /utils/add_user.sh

EXPOSE 137/udp 138/udp 139/tcp 445/tcp

VOLUME [ "/data" ]
VOLUME [ "/shared" ]
VOLUME [ "/media" ]

ENTRYPOINT [ "smbd", "-F", "-d 2", "--no-process-group" ]
CMD []

HEALTHCHECK --interval=30s --timeout=10s \
    CMD smbclient -L \\localhost -U % -m SMB3
