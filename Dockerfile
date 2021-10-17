FROM rustlang/rust:nightly-slim AS builder

RUN cargo install grcov

FROM rustlang/rust:nightly-slim

# Install tools.
RUN rustup component add llvm-tools-preview

# Install dependencies.
COPY --from=gcr.io/zeedeebee/zetasql /usr/local/bin/zetasql_server /usr/local/bin/zetasql_server
COPY --from=gcr.io/zeedeebee/sccache /usr/local/bin/sccache /usr/local/bin/sccache
COPY --from=builder /usr/local/cargo/bin/grcov /usr/local/bin/grcov

CMD ["sh"]

