FROM rust:slim-buster AS builder

RUN cargo install grcov

FROM rust:slim-buster

# Switch to rust nightly.
RUN rustup toolchain install nightly-2021-05-17 && \
    rustup default nightly-2021-05-17

# Install tools.
RUN rustup component add llvm-tools-preview

# Install dependencies.
COPY --from=gcr.io/zeedeebee/zetasql /usr/local/bin/zetasql_server /usr/local/bin/zetasql_server
COPY --from=gcr.io/zeedeebee/sccache /usr/local/bin/sccache /usr/local/bin/sccache
COPY --from=builder /usr/local/cargo/bin/grcov /usr/local/bin/grcov

CMD ["sh"]

