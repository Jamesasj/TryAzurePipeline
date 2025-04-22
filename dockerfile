FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Instala dependências do agente e do .NET
RUN apt-get update && apt-get install -y \
  curl \
  sudo \
  git \
  jq \
  unzip \
  libcurl4 \
  libunwind8 \
  net-tools \
  libssl1.1 \
  libicu66 \
  ca-certificates \
  apt-transport-https \
  && apt-get clean

# Cria diretório do agente
RUN useradd -m azagent && mkdir -p /azagent && chown azagent /azagent
WORKDIR /azagent


# Baixa o agente
RUN curl -LsS https://vstsagentpackage.azureedge.net/agent/4.254.0/vsts-agent-linux-x64-4.254.0.tar.gz | tar -xz

# Copia entrypoint
COPY entrypoint.sh .

RUN chmod +x ./entrypoint.sh

USER azagent

ENTRYPOINT [ "./entrypoint.sh" ]
