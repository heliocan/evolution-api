# Intro

Este repositório foi forkado de https://github.com/EvolutionAPI/evolution-api.git

# Clonagem

Clone este respositório
```shell
git clone https://github.com/heliocan/evolution-api
cd evolution-api
```

Aponte o upstream
```shell
git remote add upstream https://github.com/EvolutionAPI/evolution-api.git
```

# Trabalhando com suas alteracoes

Entre em sua main, busca e aplica (fetch + merge) as mudanças da branch main do repositório original (upstream) na sua main local.
```shell
git checkout main             # Garante que está na branch correta
git pull upstream main        # Traz atualizações do repositório original
```

Crie uma branch auxiliar para seus objetivos, mantendo sua main isolada
```shell
git checkout -b lenovo
```

## Em outra máquina 
Depois de terminado edição em branch específica

```shell
git clone <URL_DO_REPOSITORIO>
cd evolution-api
git checkout lenovo
```

Crie o novo .env
```shell
nano .env
```

# Docker Build

Da raiz do projeto, suba os serviços:
```shell
docker-compose up -d --build
```

## Para destruir

```shell
docker-compose down --remove-orphans
```

Postgres data
```shell
sudo rm -r postgres_data/
```

## Comparando com MAIN

Fazer comparação entre a sua branch específica e main

Arquivos
```shell
git diff --stat main..lenovo
```

Por linhas
```shell
git diff main..lenovo
```

# Domínio Apache

Criando virtual host
```shell
sudo nano /etc/apache2/sites-available/evo.devcan.one.conf
```

Conteúdo:
```shell
<VirtualHost *:80>
    ServerName evo.devcan.one

    ProxyPreserveHost On
    ProxyPass / http://localhost:8080/
    ProxyPassReverse / http://localhost:8080/

    RewriteEngine on
    RewriteCond %{SERVER_NAME} =evo.devcan.one
    RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]

    ErrorLog ${APACHE_LOG_DIR}/evo.devcan_error.log
    CustomLog ${APACHE_LOG_DIR}/evo.devcan_access.log combined
</VirtualHost>
```

Habilita o site:

```bash
sudo a2ensite evo.devcan.one.conf
```

Reinicia o Apache:
```bash
sudo systemctl reload apache2
```

Executa o certbot
```shell
sudo certbot --apache
```

# Altere o .env

Armazenado em cofre como ".env evolution-api devcan"

# Acessando 

http://evo.devcan.one/manager