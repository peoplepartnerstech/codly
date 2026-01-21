.PHONY: help build test fmt clippy clean run check generate-lockfile

help: ## Mostra esta mensagem de ajuda
	@echo "Comandos disponíveis (para uso local, sem Docker):"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "💡 Para desenvolvimento com Docker, use o Makefile na raiz do projeto: make dev"

build: ## Compila o projeto
	cargo build --release

test: ## Executa os testes
	cargo test

fmt: ## Formata o código
	cargo fmt

clippy: ## Executa o clippy (linter)
	cargo clippy -- -D warnings

clean: ## Limpa arquivos de build
	cargo clean

run: ## Executa o servidor
	cargo run

check: ## Verifica o código sem compilar
	cargo check

generate-lockfile: ## Gera Cargo.lock
	cargo generate-lockfile
