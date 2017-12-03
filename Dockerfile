FROM heroku/heroku:16

ENV LANG C.UTF-8

# Install packages for stack and ghc
RUN apt-get update
RUN apt-get upgrade -y --assume-yes
RUN apt-get install -y --assume-yes xz-utils gcc libgmp-dev zlib1g-dev

# Remove apt caches to reduce the size of our container.
RUN rm -rf /var/lib/apt/lists/*

# Install stack to /opt/stack/bin
RUN mkdir -p /opt/stack/bin
RUN curl -L https://www.stackage.org/stack/linux-x86_64 | tar xz --wildcards --strip-components=1 -C /opt/stack/bin '*/stack'

# Create source and binaru directories.
RUN mkdir -p /opt/escape-block-rest/src
RUN mkdir -p /opt/escape-block-rest/bin
WORKDIR /opt/escape-block-rest/src

# Copy sources
COPY . /opt/escape-block-rest/src

# Set the PATH for the root user so they can use stack and compiled app
ENV PATH "$PATH:/opt/stack/bin:/opt/escape-block-rest/bin"

# Install GHC using stack, based on your app's stack.yaml file.
RUN stack --no-terminal setup

# Build application.
RUN stack --no-terminal build

# Install application binaries to /opt/escape-block-rest/bin.
RUN stack --no-terminal --local-bin-path /opt/escape-block-rest/bin install

EXPOSE 5000

# Launch the app
CMD /opt/escape-block-rest/bin/escape-block-rest-exe
