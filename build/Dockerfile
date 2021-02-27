FROM gcr.io/opensourcecoin/radicle-seed-node@sha256:8b49e7e233d810ad7f98073614f4ff3f3bb07e70c910fde1dc4f272231e9b0cf

RUN mkdir -p /radicle-seed

WORKDIR /radicle-seed
EXPOSE 12345
EXPOSE 80
EXPOSE 8888


ENTRYPOINT /radicle-seed-node -- \
             --root /radiclce-seed \
             --peer-listen ${HOST}:12345 \
             --http-listen ${HOST}:80 \
             --name ${NAME} \
             --assets-path seed/ui/public \
             < /radicle-seed/key/secret.key ${EXTRA_OPTS}
