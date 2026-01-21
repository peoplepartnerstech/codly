@echo off
REM Script batch para Windows que simula o Makefile
REM Uso: make.bat dev, make.bat up, make.bat down, etc.

if "%1"=="" goto help
if "%1"=="help" goto help
if "%1"=="dev" goto dev
if "%1"=="up" goto up
if "%1"=="down" goto down
if "%1"=="restart" goto restart
if "%1"=="logs" goto logs
if "%1"=="logs-all" goto logs-all
if "%1"=="shell" goto shell
if "%1"=="shell-db" goto shell-db
if "%1"=="clean" goto clean
if "%1"=="rebuild" goto rebuild
if "%1"=="build" goto build
if "%1"=="test" goto test
if "%1"=="fmt" goto fmt
if "%1"=="clippy" goto clippy
if "%1"=="generate-lockfile" goto generate-lockfile
if "%1"=="prod-build" goto prod-build
if "%1"=="prod-up" goto prod-up
if "%1"=="prod-down" goto prod-down
if "%1"=="swagger" goto swagger
if "%1"=="swagger-down" goto swagger-down
goto help

:dev
call :generate-lockfile
echo 🚀 Iniciando serviços em modo desenvolvimento...
docker-compose -f docker-compose.dev.yml up --build
goto end

:up
call :generate-lockfile
echo 🚀 Iniciando serviços em background...
docker-compose -f docker-compose.dev.yml up -d --build
goto end

:down
echo 🛑 Parando serviços...
docker-compose -f docker-compose.dev.yml down
goto end

:restart
echo 🔄 Reiniciando serviços...
docker-compose -f docker-compose.dev.yml restart
goto end

:logs
echo 📋 Mostrando logs...
docker-compose -f docker-compose.dev.yml logs -f backend
goto end

:logs-all
echo 📋 Mostrando todos os logs...
docker-compose -f docker-compose.dev.yml logs -f
goto end

:shell
echo 🐚 Abrindo shell no container do backend...
docker-compose -f docker-compose.dev.yml exec backend bash
goto end

:shell-db
echo 🐚 Abrindo shell no PostgreSQL...
docker-compose -f docker-compose.dev.yml exec postgres psql -U postgres -d codly
goto end

:clean
echo 🧹 Limpando containers, volumes e imagens...
docker-compose -f docker-compose.dev.yml down -v
docker system prune -f
goto end

:rebuild
call :clean
call :generate-lockfile
echo 🔨 Reconstruindo do zero...
docker-compose -f docker-compose.dev.yml up --build
goto end

:build
call :generate-lockfile
echo 🔨 Construindo imagens...
docker-compose -f docker-compose.dev.yml build
goto end

:test
echo 🧪 Executando testes...
docker-compose -f docker-compose.dev.yml exec backend cargo test
goto end

:fmt
echo ✨ Formatando código...
docker-compose -f docker-compose.dev.yml exec backend cargo fmt
goto end

:clippy
echo 🔍 Executando clippy...
docker-compose -f docker-compose.dev.yml exec backend cargo clippy
goto end

:generate-lockfile
echo 📦 Verificando Cargo.lock...
if not exist backend\Cargo.lock (
    echo Cargo.lock não encontrado. Gerando via Docker...
    docker run --rm -v "%cd%\backend:/app" -w /app rust:latest sh -c "cargo generate-lockfile 2>/dev/null || cargo build --release 2>&1 | head -5"
)
echo ✅ Cargo.lock verificado/gerado
goto :eof

:prod-build
call :generate-lockfile
echo 🏭 Construindo para produção...
docker-compose -f docker-compose.yml build
goto end

:prod-up
call :generate-lockfile
echo 🏭 Iniciando em modo produção...
docker-compose -f docker-compose.yml up -d
goto end

:prod-down
echo 🛑 Parando serviços de produção...
docker-compose -f docker-compose.yml down
goto end

:swagger
echo 📚 Iniciando Swagger UI...
docker-compose -f docker-compose.swagger.yml up -d
echo ✅ Swagger UI disponível em http://localhost:8080
goto end

:swagger-down
echo 🛑 Parando Swagger UI...
docker-compose -f docker-compose.swagger.yml down
goto end

:help
echo.
echo Comandos disponíveis:
echo.
echo   make.bat dev           - Inicia os serviços em modo desenvolvimento
echo   make.bat up            - Inicia os serviços em background
echo   make.bat down          - Para os serviços
echo   make.bat restart       - Reinicia os serviços
echo   make.bat logs          - Mostra logs do backend
echo   make.bat logs-all      - Mostra logs de todos os serviços
echo   make.bat shell         - Abre shell no container do backend
echo   make.bat shell-db       - Abre shell no PostgreSQL
echo   make.bat clean         - Remove containers, volumes e imagens
echo   make.bat rebuild       - Limpa tudo e reconstrói do zero
echo   make.bat build         - Constrói as imagens sem iniciar
echo   make.bat test          - Executa testes do Rust
echo   make.bat fmt           - Formata o código Rust
echo   make.bat clippy        - Executa clippy (linter)
echo   make.bat prod-build     - Constrói para produção
echo   make.bat prod-up       - Inicia em modo produção
echo   make.bat prod-down      - Para serviços de produção
echo   make.bat swagger        - Inicia Swagger UI (http://localhost:8080)
echo   make.bat swagger-down   - Para Swagger UI
echo.
goto end

:end
