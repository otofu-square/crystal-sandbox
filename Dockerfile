FROM crystallang/crystal

# Add this directory to container as /app
COPY . /app
WORKDIR /app

RUN apt-get update
RUN apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
RUN wget https://github.com/mongodb/mongo-c-driver/releases/download/1.1.0/mongo-c-driver-1.1.0.tar.gz \
    tar -zxvf mongo-c-driver-1.1.0.tar.gz && cd mongo-c-driver-1.1.0 \
    ./configure --prefix=/usr --libdir=/usr/lib64 \
    make \
    make install \

# Install dependencies
RUN shards install

# Build our app
RUN crystal build src/main.cr --release --no-debug

EXPOSE 3000
