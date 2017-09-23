FROM crystallang/crystal

# Add this directory to container as /app
COPY . /app
WORKDIR /app

RUN apt-get upgrade

# Install dependencies
RUN shards install

# Build our app
RUN crystal build src/main.cr --release --no-debug

EXPOSE 3000
