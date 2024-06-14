FROM registry.fedoraproject.org/fedora-toolbox:40

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="ragib.badaruddin@gmail.com"

# Setup vscode repo
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc
RUN sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

# Install some dev tools and dependencies
RUN dnf group install -y "C Development Tools and Libraries" "Development Tools"
RUN dnf install -y \
    bind-utils \
    clang \
    cmake \
    code \
    community-mysql \
    community-mysql-libs \
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
RUN echo 'eval "$(/usr/local/bin/mise activate bash)"' >> /etc/bashrc

# Activate direnv
RUN echo 'eval "$(direnv hook bash)"' >> /etc/bashrc

# Run docker on the host
RUN ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker
