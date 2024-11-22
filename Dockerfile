FROM alpine:latest AS builder

ARG INSO_DOWNLOAD_URL
ENV INSO_DOWNLOAD_URL=${INSO_DOWNLOAD_URL}

RUN apk add --no-cache curl xz && \
    curl -L ${INSO_DOWNLOAD_URL} -o inso-linux.tar.xz && \
    tar -xf inso-linux.tar.xz && \
    rm inso-linux.tar.xz


FROM alpine:latest AS runner

RUN apk add --no-cache ca-certificates

COPY --from=builder inso .

RUN chmod +x inso

ENTRYPOINT ["./inso"]
