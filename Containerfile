FROM registry.fedoraproject.org/fedora-toolbox:44

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="ragib.badaruddin@gmail.com"

# VS Code repo
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    printf '[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\n' > /etc/yum.repos.d/vscode.repo

# Dev tools + deps (single layer, cache cleaned in-place)
RUN dnf group install -y "c-development" && \
    dnf install -y \
        git \
        bind-utils clang cmake code direnv kubernetes-client \
        libcurl-devel libuuid-devel mysql mysql-libs openssl-devel \
        perl-FindBin perl-IPC-Cmd postgresql libpq libpq-devel \
        protobuf-c-compiler readline-devel uuid-devel zlib-devel && \
    dnf clean all && rm -rf /var/cache/dnf /var/cache/libdnf5 /var/log/dnf* /tmp/*

# mise + direnv
RUN curl -fsSL https://mise.jdx.dev/mise-latest-linux-x64 -o /usr/local/bin/mise && \
    chmod a+x /usr/local/bin/mise && \
    echo 'eval "$(/usr/local/bin/mise activate bash)"' >> /etc/bashrc && \
    echo 'eval "$(direnv hook bash)"' >> /etc/bashrc

# Use the host's docker
RUN ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker
