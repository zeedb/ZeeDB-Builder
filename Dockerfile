FROM rust:slim-buster

# Install dependencies.
COPY --from=gcr.io/zeedeebee/zetasql /usr/local/bin/zetasql_server /usr/local/bin/zetasql_server
COPY --from=gcr.io/zeedeebee/sccache /usr/local/bin/sccache /usr/local/bin/sccache

# Switch to rust nightly.
RUN rustup toolchain install nightly-2021-05-10 && \
    rustup default nightly-2021-05-10

CMD ["cargo"]

