FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /var/www

# Install needed packages.
RUN apt-get update
RUN apt-get install build-essential -y
RUN apt-get install curl -y

RUN apt-get install -y git \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash -\
    && apt-get install -y nodejs \
    && curl -L https://foundry.paradigm.xyz | bash \
    && curl https://sh.rustup.rs -sSf | bash -s -- -y \
    && curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s --

ENV PATH="/root/.cargo/bin:${PATH}"
ENV PATH="/root/bin:${PATH}"
ENV PATH="/root/.foundry/bin:${PATH}"

RUN rustup update stable

RUN git clone https://github.com/open-ibc/ibc-app-solidity-template.git

WORKDIR /var/www/ibc-app-solidity-template

COPY .env .

RUN cargo install --git https://github.com/foundry-rs/foundry --profile local --locked forge \
    && just install

