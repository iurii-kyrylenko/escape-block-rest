FROM heroku/heroku:18

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

# Set the PATH for the root user so they can use stack
ENV PATH "$PATH:/opt/stack/bin"
