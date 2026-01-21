.PHONY: help dev build up down logs shell clean rebuild test fmt clippy generate-lockfile

# Default target
help: ## Mostra esta mensagem de ajuda
	@echo "Comandos disponíveis:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Docker commands
dev: generate-lockfile ## Inicia os serviços em modo desenvolvimento
	@echo "🚀 Iniciando serviços em modo desenvolvimento..."
	docker-compose -f docker-compose.dev.yml up --build

up: generate-lockfile ## Inicia os serviços em background
	@echo "🚀 Iniciando serviços em background..."
	docker-compose -f docker-compose.dev.yml up -d --build

down: ## Para os serviços
	@echo "🛑 Parando serviços..."
	docker-compose -f docker-compose.dev.yml down

restart: ## Reinicia os serviços
	@echo "🔄 Reiniciando serviços..."
	docker-compose -f docker-compose.dev.yml restart

logs: ## Mostra logs do backend
	@echo "📋 Mostrando logs..."
	docker-compose -f docker-compose.dev.yml logs -f backend

logs-all: ## Mostra logs de todos os serviços
	@echo "📋 Mostrando todos os logs..."
	docker-compose -f docker-compose.dev.yml logs -f

shell: ## Abre shell no container do backend
	@echo "🐚 Abrindo shell no container do backend..."
	docker-compose -f docker-compose.dev.yml exec backend bash

shell-db: ## Abre shell no PostgreSQL
	@echo "🐚 Abrindo shell no PostgreSQL..."
	docker-compose -f docker-compose.dev.yml exec postgres psql -U postgres -d codly

clean: ## Remove containers, volumes e imagens
	@echo "🧹 Limpando containers, volumes e imagens..."
	docker-compose -f docker-compose.dev.yml down -v
	docker system prune -f

rebuild: clean generate-lockfile ## Limpa tudo e reconstrói do zero
	@echo "🔨 Reconstruindo do zero..."
	docker-compose -f docker-compose.dev.yml up --build

build: generate-lockfile ## Constrói as imagens sem iniciar
	@echo "🔨 Construindo imagens..."
	docker-compose -f docker-compose.dev.yml build

# Rust commands (dentro do container)
test: ## Executa testes do Rust
	@echo "🧪 Executando testes..."
	docker-compose -f docker-compose.dev.yml exec backend cargo test

fmt: ## Formata o código Rust
	@echo "✨ Formatando código..."
	docker-compose -f docker-compose.dev.yml exec backend cargo fmt

clippy: ## Executa clippy (linter)
	@echo "🔍 Executando clippy..."
	docker-compose -f docker-compose.dev.yml exec backend cargo clippy

# Utility commands
generate-lockfile: ## Gera Cargo.lock se não existir (via Docker)
	@echo "📦 Verificando Cargo.lock..."
	@test -f backend/Cargo.lock || ( \
		echo "Cargo.lock não encontrado. Gerando via Docker..." && \
        docker run --rm -v "$$(pwd)/backend:/app" -w /app rust:latest sh -c "cargo generate-lockfile 2>/dev/null || cargo build --release 2>&1 | head -5" \
	)
	@echo "✅ Cargo.lock verificado/gerado"

# Production commands
prod-build: generate-lockfile ## Constrói para produção
	@echo "🏭 Construindo para produção..."
	docker-compose -f docker-compose.yml build

prod-up: generate-lockfile ## Inicia em modo produção
	@echo "🏭 Iniciando em modo produção..."
	docker-compose -f docker-compose.yml up -d

prod-down: ## Para serviços de produção
	@echo "🛑 Parando serviços de produção..."
	docker-compose -f docker-compose.yml down

# Swagger/OpenAPI
swagger: ## Inicia Swagger UI para visualizar OpenAPI
	@echo "📚 Iniciando Swagger UI..."
	docker-compose -f docker-compose.swagger.yml up -d
	@echo "✅ Swagger UI disponível em http://localhost:8080"

swagger-down: ## Para Swagger UI
	@echo "🛑 Parando Swagger UI..."
	docker-compose -f docker-compose.swagger.yml down
