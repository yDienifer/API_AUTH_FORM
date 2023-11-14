#!/bin/sh
# É conhecido como "shebang" e é uma construção usada em scripts de shell Unix e Linux. Essa linha no início do script indica qual interpretador de shell deve ser usado para executar o script. No seu caso, #!/bin/sh indica que o script deve ser interpretado pelo shell Bourne.

# Encerra a execução do script quando ocorrer um erro na execução
set -e

# Aguarda até que seja possível se conectar ao banco de dados PostgreSQL. O loop imprime uma mensagem e aguarda por 2 segundos antes de tentar novamente.
while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
  echo "🟡 Waiting for Postgres Database Startup ($POSTGRES_HOST $POSTGRES_PORT) ..."
  sleep 2
done

echo "✅ Postgres Database Started Successfully ($POSTGRES_HOST:$POSTGRES_PORT)"

# Comandos do Django para coletar arquivos estáticos, criar migrações, aplicar migrações e iniciar o servidor de desenvolvimento do Django.
python manage.py collectstatic --noinput
python manage.py makemigrations --noinput
python manage.py migrate --noinput
python manage.py runserver 0.0.0.0:8000