FROM python:3.11.3-alpine3.18
LABEL mantainer="dienifersiqueira.dev@gmail.com"

# controla se o python deve gravar arquivos bytecode(.pyc) no disco. (1 = não, 0 = sim)
ENV PYTHONDONTWRITEBYTECODE 1 

# Garante que a saída do Python seja enviada diretamente e somente para o terminal.
ENV PYTHONUNBUFFERED 1 

# copia a pasta 'user-registration' e 'scripts' para dentro do container docker.
COPY ./user_registration /user_registration
COPY ./scripts /scripts

# entra na pasta
WORKDIR /user_registration
# é a porta em que conexões externas poderam ter acesso ao container(usado no django, tb)
EXPOSE 8000

# Executa comandos para construir a imagem
# Resultado é armazenado no sistema de arquivos da imagem na nova camada.
# Agrupar todos os comandos em um rum poupa a quantidade de camadas(a torna mais eficiente)
RUN python -m venv /venv && \
  /venv/bin/pip install --upgrade pip && \
  /venv/bin/pip install -r /user_registration/requirements.txt && \
  adduser --disabled-password --no-create-home duser && \
  mkdir -p /data/web/static && \
  mkdir -p /data/web/media && \
  chown -R duser:duser /venv && \
  chown -R duser:duser /data/web/static && \
  chown -R duser:duser /data/web/media && \
  chmod -R 755 /data/web/static && \
  chmod -R 755 /data/web/media && \
  chmod -R +x /scripts &&\
  /venv/bin/pip cache purge
# && \ indica para o python que tem mais uma linha depois do comando

# Adiciona a pasta scripts e venv/bin 
# no $PATH do container.
# Todos os comandos executados no ambiente virtual irão buscar nessas pastas do ambiente virtual
ENV PATH="/scripts:/venv/bin:$PATH"

# Muda o usuário para duser
USER duser

# Executa o arquivo scripts/commands.sh
CMD ["commands.sh"]