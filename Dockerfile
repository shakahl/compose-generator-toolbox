FROM alpine:3.13.5

# Install alpine packages
RUN apk update && apk add --no-cache sudo=1.9.5p2-r0 bash=5.1.0-r0 curl=7.77.0-r0 git=2.30.2-r0 npm=14.16.1-r1 yarn=1.22.10-r0 unzip=6.0-r8 python3=3.8.10-r0 py3-pip=20.3.4-r0 rust=1.47.0-r2 ruby=2.7.3-r0  && rm -rf /var/cache/apk/*

# Install required npm packages
RUN yarn global add @angular/cli @vue/cli

# Install pip dependencies
RUN pip3 install --no-cache-dir flask-now==0.2.2

# Install gem packages
RUN gem install rails:6.1.3.2

# Install golang
RUN apk add --no-cache --virtual .build-deps gcc=10.2.1_pre1-r3 musl-dev=1.2.2-r0 go=1.15.10-r0 openssl=1.1.1k-r0 && curl -sSL -o go.tar.gz https://golang.org/dl/go1.16.3.src.tar.gz && tar -C /usr/local -xzf go.tar.gz
WORKDIR /usr/local/go/src/
RUN ./make.bash && apk del .build-deps
ENV PATH="/usr/local/go/bin:$PATH"
ENV GOPATH=/opt/go/
ENV PATH=$PATH:$GOPATH/bin

WORKDIR /toolbox
ENTRYPOINT [ "/bin/bash", "-c"]