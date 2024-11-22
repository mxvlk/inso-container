# Use the latest Alpine base image
FROM alpine:latest

# Install necessary packages and clean up
RUN apk add --no-cache curl xz ca-certificates

# Set the working directory
WORKDIR /work

# Fetch the Inso binary dynamically
ARG INSO_DOWNLOAD_URL
ENV INSO_DOWNLOAD_URL=${INSO_DOWNLOAD_URL}

RUN echo "${INSO_DOWNLOAD_URL}"
RUN curl -L ${INSO_DOWNLOAD_URL} -o inso-linux.tar.xz

# Extract the tar file and clean up
RUN tar -xf inso-linux.tar.xz && \
    rm inso-linux.tar.xz

# Ensure the inso binary is executable
RUN chmod +x inso

# Set the entrypoint to the inso binary
ENTRYPOINT ["./inso"]
