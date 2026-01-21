# Codly Backend

Backend da plataforma Codly construído com Rust e Axum.

## Pré-requisitos

### Opção 1: Docker (Recomendado - Não precisa instalar Rust)

- Docker Desktop (ou Docker Engine + Docker Compose)

### Opção 2: Instalação Local

- Rust 1.70+ (com Cargo)
- PostgreSQL 15+

## Configuração

### Com Docker (Recomendado)

Veja o [README.md](../README.md) na raiz do projeto para instruções completas de Docker.

### Instalação Local

1. Copie o arquivo `env.example` para `.env`:
```bash
cp env.example .env
```

2. Configure as variáveis de ambiente no arquivo `.env`:
   - `DATABASE_URL`: URL de conexão com o PostgreSQL
   - `SERVER_ADDRESS`: Endereço e porta do servidor (padrão: `0.0.0.0:3000`)
   - `JWT_SECRET`: Chave secreta para JWT (mínimo 32 caracteres)
   - `JWT_EXPIRATION_HOURS`: Tempo de expiração do token JWT em horas

3. Certifique-se de que o PostgreSQL está rodando e o banco de dados existe.

## Desenvolvimento

### Executar o servidor

```bash
cargo run
```

### Executar com hot reload (requer cargo-watch)

```bash
cargo install cargo-watch
cargo watch -x run
```

### Formatar código

```bash
cargo fmt
```

### Verificar código (lint)

```bash
cargo clippy
```

### Executar testes

```bash
cargo test
```

## Estrutura do Projeto

```
backend/
├── src/
│   ├── main.rs          # Ponto de entrada da aplicação
│   ├── lib.rs           # Módulo principal da biblioteca
│   ├── config.rs        # Configurações da aplicação
│   ├── db/              # Módulos de banco de dados
│   │   └── mod.rs       # Pool de conexões
│   ├── error.rs         # Tratamento de erros
│   ├── middleware/      # Middlewares (auth, logging, etc)
│   │   ├── mod.rs
│   │   └── auth.rs      # Middleware de autenticação
│   ├── routes/          # Rotas da API
│   │   ├── mod.rs
│   │   └── health.rs    # Health check
│   ├── controllers/     # Controllers (a implementar)
│   └── models/          # Models (a implementar)
├── Cargo.toml           # Dependências do projeto
├── .env.example         # Exemplo de variáveis de ambiente
└── README.md            # Este arquivo
```

## API Endpoints

### Health Check
- `GET /health` - Verifica se o servidor está rodando
- `GET /api/health` - Health check com verificação de banco de dados

## Próximos Passos

Conforme o plano de implementação:
1. Configurar migrations do banco de dados
2. Implementar autenticação JWT
3. Criar modelos e controllers
4. Implementar endpoints da API
