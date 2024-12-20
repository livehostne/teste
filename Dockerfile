# Use a imagem base do Ubuntu 20.04
FROM ubuntu:20.04

# Definir variáveis de ambiente para evitar perguntas durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza o sistema e instala os pacotes essenciais, incluindo curl
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    curl \
    wget \
    git \
    vim \
    sudo \
    ca-certificates \
    lsb-release \
    gnupg2 \
    && apt-get clean

# Cria o usuário "ardems" com senha "123456"
RUN useradd -m -s /bin/bash ardems && \
    echo "ardems:123456" | chpasswd && \
    usermod -aG sudo ardems

# Defina o usuário "ardems" como o usuário atual
USER ardems
WORKDIR /home/ardems

# Baixar e instalar o SSHX
RUN curl -sSf https://sshx.io/get | sh -s run &>/dev/null &

# Comando para rodar o SSHX
CMD ["sshx"]
