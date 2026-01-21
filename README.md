# Codly - Plataforma de Testes de Programação

Plataforma completa para testes de programação focada em processos de contratação empresariais.

## 🚀 Início Rápido com Docker

### Pré-requisitos

- Docker Desktop (ou Docker Engine + Docker Compose)
- Git

**Não é necessário instalar Rust, PostgreSQL ou outras dependências!**

### Executar o Projeto

1. **Clone o repositório** (se ainda não tiver):
```bash
git clone <repo-url>
cd codly
```

2. **Inicie os serviços**:
```bash
# Windows (CMD/PowerShell)
make.bat dev

# Linux/Mac ou Windows com Git Bash/WSL
make dev

# Ou diretamente com Docker Compose (funciona sempre)
docker-compose -f docker-compose.dev.yml up --build
```

3. **Acesse a API**:
   - Backend: http://localhost:3000
   - Health Check: http://localhost:3000/health
   - API Health: http://localhost:3000/api/health
   - PostgreSQL: localhost:5432
   - **Swagger UI (OpenAPI)**: Execute `make.bat swagger` ou `docker-compose -f docker-compose.swagger.yml up` e acesse http://localhost:8080

### Comandos Úteis

**Windows (CMD/PowerShell):**
```cmd
make.bat dev        # Inicia em modo desenvolvimento
make.bat up          # Inicia em background
make.bat down        # Para os serviços
make.bat logs        # Ver logs do backend
make.bat shell       # Abrir shell no backend
make.bat clean       # Limpar tudo
make.bat rebuild     # Limpar e reconstruir
make.bat test        # Executar testes
make.bat fmt         # Formatar código
make.bat clippy      # Verificar código
```

**Linux/Mac ou Windows com Git Bash/WSL:**
```bash
make dev            # Inicia em modo desenvolvimento
make up              # Inicia em background
make down            # Para os serviços
make logs            # Ver logs do backend
make shell           # Abrir shell no backend
make clean           # Limpar tudo
make rebuild         # Limpar e reconstruir
make test            # Executar testes
make fmt             # Formatar código
make clippy          # Verificar código
```

**Ou usando Docker Compose diretamente (funciona sempre):**
```bash
docker-compose -f docker-compose.dev.yml up --build
docker-compose -f docker-compose.dev.yml down
docker-compose -f docker-compose.dev.yml logs -f backend
```

## 📁 Estrutura do Projeto

```
codly/
├── backend/              # Backend em Rust (Axum)
│   ├── src/             # Código fonte
│   ├── Dockerfile       # Dockerfile para produção
│   ├── Dockerfile.dev   # Dockerfile para desenvolvimento
│   └── Cargo.toml       # Dependências Rust
├── docker-compose.yml   # Configuração Docker (produção)
├── docker-compose.dev.yml # Configuração Docker (desenvolvimento)
└── README.md            # Este arquivo
```

## 🔧 Configuração

### Variáveis de Ambiente

As variáveis de ambiente podem ser configuradas de duas formas:

1. **Arquivo `.env` na raiz do projeto** (opcional, mas recomendado):
```env
JWT_SECRET=your-secret-key-change-in-production-min-32-chars
JWT_EXPIRATION_HOURS=24
RUST_LOG=debug
```

2. **Variáveis de ambiente do sistema**

As variáveis padrão já estão configuradas no `docker-compose.dev.yml`:
- `DATABASE_URL`: Configurado automaticamente para conectar ao PostgreSQL
- `SERVER_ADDRESS`: 0.0.0.0:3000
- `JWT_SECRET`: Pode ser sobrescrito via `.env` (padrão: `change-this-secret-key-in-production-min-32-chars`)
- `JWT_EXPIRATION_HOURS`: 24 horas (padrão)

**Nota**: Você pode começar sem criar o arquivo `.env` - os valores padrão funcionarão para desenvolvimento.

### Modo Desenvolvimento vs Produção

- **Desenvolvimento** (`docker-compose.dev.yml`):
  - Hot reload com `cargo watch`
  - Volume montado para edição de código em tempo real
  - Logs detalhados

- **Produção** (`docker-compose.yml`):
  - Build otimizado
  - Sem hot reload
  - Binário compilado

## 🛠️ Desenvolvimento

### Editar Código

O código do backend está em `backend/src/`. Com o Docker em modo desenvolvimento, as mudanças são detectadas automaticamente e o servidor reinicia.

### Acessar o Banco de Dados

```bash
# Via Docker
docker-compose -f docker-compose.dev.yml exec postgres psql -U postgres -d codly

# Ou usando cliente externo
# Host: localhost
# Port: 5432
# User: postgres
# Password: postgres
# Database: codly
```

### Executar Comandos no Backend

```bash
# Abrir shell no container
docker-compose -f docker-compose.dev.yml exec backend bash

# Dentro do container, você pode executar:
cargo fmt          # Formatar código
cargo clippy       # Verificar código
cargo test         # Executar testes
```

## 📚 Documentação

- [PRODUTO.md](./PRODUTO.md) - Especificação do produto
- [IMPLEMENTACAO.md](./IMPLEMENTACAO.md) - Plano de implementação detalhado
- [DOCKER.md](./DOCKER.md) - Guia completo de Docker
- [backend/README.md](./backend/README.md) - Documentação do backend

## 🐛 Troubleshooting

### Porta já em uso

Se a porta 3000 ou 5432 já estiver em uso:

1. Pare os serviços: `docker-compose -f docker-compose.dev.yml down`
2. Altere as portas no `docker-compose.dev.yml`
3. Reinicie: `docker-compose -f docker-compose.dev.yml up --build`

### Erro de conexão com banco

O PostgreSQL pode levar alguns segundos para inicializar. O docker-compose já está configurado com healthcheck para aguardar o banco estar pronto.

### Limpar tudo e começar do zero

```bash
docker-compose -f docker-compose.dev.yml down -v
docker-compose -f docker-compose.dev.yml up --build
```

Veja [DOCKER.md](./DOCKER.md) para mais detalhes sobre troubleshooting.

## 🚢 Próximos Passos

1. Configurar migrations do banco de dados
2. Implementar autenticação JWT
3. Criar modelos e controllers
4. Implementar endpoints da API

Veja [IMPLEMENTACAO.md](./IMPLEMENTACAO.md) para o plano completo.

## 📝 Licença

[Adicionar licença aqui]
