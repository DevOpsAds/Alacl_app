FROM python:3.11.3-alpine3.18
LABEL maintainer="joaobatistalimajunior.ads@gmail.com"

# Definir variáveis de ambiente
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Copiar a aplicação Django e scripts para dentro do container
COPY djangoapp /djangoapp
COPY scripts /scripts

# Definir o diretório de trabalho
WORKDIR /djangoapp

# Expor a porta 8000
EXPOSE 8000

# Instalar dependências Python
RUN python -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r /djangoapp/requirements.txt

# Criar usuário não privilegiado e diretórios
RUN adduser --disabled-password --no-create-home duser && \
    mkdir -p /data/web/static /data/web/media && \
    chown -R duser:duser /venv /data/web && \
    chmod -R 755 /data/web && \
    chmod -R +x /scripts && \
    mkdir -p /data/web/static/admin && \
    chown -R duser:duser /data/web/static/admin

# Adicionar diretórios e executáveis ao PATH do usuário
ENV PATH="/scripts:/venv/bin:$PATH"

# Alterar para o usuário não privilegiado
#USER duser

# Executar o script commands.sh
CMD ["commands.sh"]
