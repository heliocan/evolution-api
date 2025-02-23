#!/bin/bash

# Importa funções auxiliares (se necessário)
source ./Docker/scripts/env_functions.sh

# Verifica se o ambiente é Docker
if [ "$DOCKER_ENV" != "true" ]; then
    export_env_vars
fi

# Verifica o provedor de banco de dados
if [[ "$DATABASE_PROVIDER" == "postgresql" || "$DATABASE_PROVIDER" == "mysql" ]]; then
    # Exporta a variável DATABASE_URL
    export DATABASE_URL="$DATABASE_CONNECTION_URI"
    echo "Deploying migrations for $DATABASE_PROVIDER"
    echo "Database URL: $DATABASE_URL"

    # Aplica as migrações do Prisma
    npm run db:deploy
    if [ $? -ne 0 ]; then
        echo "Migration failed"
        exit 1
    else
        echo "Migration succeeded"
    fi

    # Gera o schema do Prisma
    npm run db:generate
    if [ $? -ne 0 ]; then
        echo "Prisma generate failed"
        exit 1
    else
        echo "Prisma generate succeeded"
    fi
else
    echo "Error: Database provider $DATABASE_PROVIDER invalid."
    exit 1
fi
