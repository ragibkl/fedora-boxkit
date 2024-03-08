FROM registry.fedoraproject.org/fedora-toolbox:39

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="ragib.badaruddin@gmail.com"

# Install some dev tools and dependencies
RUN dnf group install -y "C Development Tools and Libraries" "Development Tools"
RUN dnf install -y \
    bind-utils \
    clang \
    cmake \
    direnv \
    kubernetes-client \
    libcurl-devel \
    libuuid-devel \
    openssl-devel \
    perl-FindBin \
    perl-IPC-Cmd \
    protobuf-c-compiler \
    readline-devel \
    uuid-devel \
    zlib-devel

# Install mise
RUN wget https://mise.jdx.dev/mise-latest-linux-x64 && \
    mv mise-latest-linux-x64 /usr/local/bin/mise && \
    chmod a+x /usr/local/bin/mise

# Activate mise
COPY mise-profile.sh /etc/profile.d/mise-profile.sh

# Activate direnv
COPY direnv-profile.sh /etc/profile.d/direnv-profile.sh

# Run vscode on the host and attach to current container
COPY code.sh /usr/local/bin/code

# Run docker on the host
RUN ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker
