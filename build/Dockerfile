FROM node:buster as builder-ui

ENV DEBIAN_FRONTEND=noninteractive

ARG UPSTREAM_VERSION

RUN apt update && apt install -y git

WORKDIR /radicle

RUN git clone https://github.com/radicle-dev/radicle-bins.git . && git checkout ${UPSTREAM_VERSION}

RUN (cd seed/ui && yarn && yarn build)

FROM liuchong/rustup:nightly as builder-seed

WORKDIR /radicle
COPY --from=builder-ui /radicle /radicle

RUN cargo build -p radicle-seed-node --release
RUN cargo build -p radicle-keyutil --release

RUN cp ./target/release/radicle-seed-node /radicle/seed-node
RUN cp ./target/release/radicle-keyutil /radicle/key-util

COPY ./docker-entrypoint.sh /radicle/docker-entrypoint.sh

RUN mkdir -p /radicle-seed

EXPOSE 10001
EXPOSE 8888

ENTRYPOINT ["bash","docker-entrypoint.sh"]
