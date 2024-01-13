FROM quay.io/toolbx-images/fedora-toolbox:39

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="ragib.badaruddin@gmail.com"

RUN dnf group install -y "C Development Tools and Libraries"
RUN dnf group install -y "Development Tools"
RUN wget https://mise.jdx.dev/mise-latest-linux-x64 && \
    mv mise-latest-linux-x64 /usr/local/bin/mise && \
    chmod a+x /usr/local/bin/mise

COPY mise-profile.sh /etc/profile.d/mise-profile.sh
COPY code.sh /usr/local/bin/code

RUN ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker
