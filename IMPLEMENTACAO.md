# Plano de Implementação - Codly

## 📊 Status do Projeto

**Última atualização:** Backend Setup completo, Docker configurado, OpenAPI documentado, scripts de desenvolvimento criados

### ✅ Concluído

#### Fase 1 - Backend Setup
- ✅ Projeto Rust com Axum configurado e funcionando
- ✅ Estrutura de pastas completa (controllers, routes, middleware, db, models)
- ✅ Cargo.toml com todas as dependências necessárias (axum, tokio, sqlx, jwt, bcrypt, etc)
- ✅ Sistema de configuração com variáveis de ambiente (dotenv)
- ✅ Configuração de rustfmt e clippy
- ✅ Conexão com PostgreSQL usando sqlx com pool de conexões
- ✅ Async runtime Tokio configurado
- ✅ Router Axum com rotas básicas e health check
- ✅ Middleware completo: CORS, logging (tracing), error handling customizado
- ✅ Sistema de tratamento de erros com AppError e Result<T>
- ✅ Endpoint GET /api/health implementado (verifica servidor e banco de dados)
- ✅ OpenAPI 3.0.3 documentado (backend/openapi.yaml)
- ✅ Warnings de código não utilizado corrigidos (#[allow(dead_code)])
- ✅ Versão do Rust atualizada para `latest` (suporta edition2024)

#### Fase 1 - Docker Setup
- ✅ Docker Compose configurado (produção e desenvolvimento)
- ✅ Container PostgreSQL 15 com healthcheck
- ✅ Container Backend Rust configurado
- ✅ Dockerfile para produção (build otimizado)
- ✅ Dockerfile.dev para desenvolvimento
- ✅ Configuração Docker Compose completa
- ✅ Rede Docker configurada entre containers
- ✅ Volumes para persistência de dados e cache de build
- ✅ Versão do Rust atualizada para `latest` (suporta edition2024)
- ✅ Scripts de desenvolvimento (Makefile e make.bat para Windows)
- ✅ Swagger UI configurado via Docker (docker-compose.swagger.yml)

**Arquivos criados:**
- `backend/src/main.rs` - Entry point da aplicação
- `backend/src/config.rs` - Configurações da aplicação
- `backend/src/db/mod.rs` - Pool de conexões PostgreSQL
- `backend/src/error.rs` - Sistema de tratamento de erros
- `backend/src/routes/` - Rotas da API (health check)
- `backend/src/middleware/` - Middlewares (auth placeholder)
- `backend/src/controllers/` - Controllers (estrutura preparada)
- `backend/src/models/` - Models (estrutura preparada)
- `backend/Dockerfile` e `backend/Dockerfile.dev`
- `docker-compose.yml` e `docker-compose.dev.yml`
- `docker-compose.swagger.yml` - Swagger UI para visualizar OpenAPI
- `Makefile` - Comandos para Linux/Mac
- `make.bat` - Comandos para Windows
- `backend/openapi.yaml` - Especificação OpenAPI 3.0.3
- `backend/rustfmt.toml` e `backend/.clippy.toml` - Configurações de formatação
- `backend/.gitignore` - Arquivos ignorados pelo Git
- `backend/env.example` - Exemplo de variáveis de ambiente
- `README.md` - Documentação principal do projeto

### 🚧 Em Andamento
- Nenhum no momento

### 📋 Próximos Passos
- Fase 1 - Banco de Dados: Criar migrations e schema inicial
- Fase 1 - Autenticação: Implementar JWT para empresas
- Fase 1 - Setup Inicial: Criar empresa admin e seed inicial

### 📝 Documentação Criada
- ✅ README.md - Documentação principal com instruções de uso
- ✅ backend/openapi.yaml - Especificação OpenAPI 3.0.3
- ✅ Makefile e make.bat - Scripts de desenvolvimento
- ✅ Configurações de formatação (rustfmt.toml, .clippy.toml)

### 📚 OpenAPI / Documentação da API
- ✅ Especificação OpenAPI 3.0.3 criada (backend/openapi.yaml)
- ✅ Endpoint GET /api/health documentado com:
  - Schema de resposta completo
  - Exemplos de resposta
  - Descrição detalhada
- ✅ Swagger UI configurado via Docker (docker-compose.swagger.yml)
- ✅ Comandos para visualizar: `make.bat swagger` ou `make swagger`
- ✅ Acessível em http://localhost:8080 quando Swagger UI estiver rodando
- ✅ Arquivo OpenAPI pode ser importado em Postman, Insomnia, Swagger Editor, etc.

---

## Fase 1: Setup Inicial e Infraestrutura

### Backend Setup
- [x] Configurar projeto Rust com Axum como framework web
- [x] Configurar estrutura de pastas (handlers, routes, middleware, db, models)
- [x] Configurar Cargo.toml com dependências:
  - [x] axum (framework web)
  - [x] tokio (async runtime)
  - [x] tower (middleware e serviços)
  - [x] tower-http (middleware HTTP)
  - [x] serde (serialização/deserialização)
  - [x] sqlx ou diesel (ORM/query builder) - usando sqlx
  - [x] jsonwebtoken (JWT)
  - [x] bcrypt (hash de senhas)
  - [x] dotenv (variáveis de ambiente)
  - [x] uuid (geração de tokens)
- [x] Configurar variáveis de ambiente (.env com dotenv)
- [x] Configurar rustfmt e clippy (formatação e linting)
- [x] Configurar scripts de build e desenvolvimento (Makefile + scripts Docker)
- [x] Configurar conexão com PostgreSQL (sqlx ou diesel) - usando sqlx
- [x] Configurar async runtime (tokio)
- [x] Configurar router do Axum
- [x] Configurar middleware (CORS, logging, error handling)

### Banco de Dados
- [ ] Instalar e configurar PostgreSQL
- [ ] Criar schema inicial do banco de dados
- [ ] Criar migrations para todas as tabelas:
  - [ ] users (apenas empresas - candidatos não têm conta)
  - [ ] companies
  - [ ] **test_templates** (templates de teste criados pelas empresas)
    - [ ] Campos: id, company_id, title, description, language, duration (minutos), expires_at (expiração do template), allow_resume (boolean - permite pausar e continuar), status, created_at
  - [ ] **test_instances** (instâncias únicas do teste para cada candidato)
    - [ ] Campos: id, test_template_id, candidate_name (obrigatório), candidate_email (opcional), unique_token (para link), link_expires_at (expiração do link), started_at, expires_at (calculado - expiração do teste após iniciar), status, created_at, completed_at, ai_reviewed_at
    - [ ] **Status (enum):**
      - [ ] pending (Criado - link gerado, não iniciado)
      - [ ] in_progress (Iniciado - teste em andamento)
      - [ ] completed (Concluído - teste finalizado)
      - [ ] ai_reviewed (Revisado pela IA - análise de IA concluída)
    - [ ] **Campos para controle de pausa (quando allow_resume = true):**
      - [ ] paused_at (timestamp quando pausou)
      - [ ] resumed_at (timestamp quando retomou)
      - [ ] total_paused_time (tempo total pausado em segundos)
      - [ ] current_question_id (questão atual)
    - [ ] **Timestamps de transição de status:**
      - [ ] started_at (quando mudou para in_progress)
      - [ ] completed_at (quando mudou para completed)
      - [ ] ai_reviewed_at (quando mudou para ai_reviewed)
    - [ ] **NOTA: candidate_id removido - candidatos não têm conta, identificados apenas pelo token**
    - [ ] **link_expires_at: define até quando o link pode ser usado (antes de iniciar o teste)**
  - [ ] **test_instance_states** (estado salvo do teste - quando allow_resume = true)
    - [ ] Campos: id, test_instance_id, question_id, code_content (texto do código digitado), last_updated_at
    - [ ] **Salva código digitado por questão para permitir continuar depois**
  - [ ] **test_template_questions** (relação many-to-many entre templates e questões)
    - [ ] Campos: test_template_id, question_id, order_index
  - [ ] questions
  - [ ] test_cases
  - [ ] submissions (vinculado a test_instance_id)
  - [ ] test_results
  - [ ] code_reviews
  - [ ] review_comments
  - [ ] **activity_logs** (logs de atividade do candidato durante o teste)
    - [ ] Campos: id, test_instance_id, event_type, event_data (JSON), timestamp, metadata
- [ ] Criar índices para performance
- [ ] **Criar índice em test_instances.unique_token para busca rápida por link**
- [ ] **Criar índice em test_instances.expires_at para queries de instâncias expiradas**
- [ ] **Criar índice em test_instances.link_expires_at para queries de links expirados**
- [ ] **Criar índice em test_templates.expires_at para queries de templates expirados**
- [ ] **Criar índice em test_instance_states.test_instance_id para carregar estado rapidamente**
- [ ] **Criar índice em test_instances.status para filtros e queries por status**
- [x] Configurar conexão com pool de conexões

### Docker Setup
- [x] Configurar docker-compose.yml
- [x] Container PostgreSQL
- [ ] Containers para execução de código (Python, Java) - será feito na Fase 3
- [x] Configurar rede entre containers
- [x] Testar comunicação entre serviços
- [x] Configurar Dockerfile para produção
- [x] Configurar Dockerfile.dev para desenvolvimento
- [x] Configurar Docker Compose para desenvolvimento e produção
- [x] Configurar volumes para persistência de dados e cache de build
- [x] Atualizar versão do Rust para `latest` (suporta edition2024)
- [x] Criar scripts de desenvolvimento (Makefile e make.bat)
- [x] Configurar Swagger UI via Docker (docker-compose.swagger.yml)

### Autenticação
- [ ] Implementar registro de usuários (apenas empresas)
- [ ] Implementar login com JWT (apenas empresas)
- [ ] Criar middleware de autenticação JWT
- [ ] Criar middleware de autorização por roles (company, admin)
- [ ] Implementar refresh tokens (opcional)
- [ ] **Acesso de candidatos:**
  - [ ] Validar token único do link (sem autenticação JWT)
  - [ ] Middleware para validar token único de instância
  - [ ] Não requerer autenticação para endpoints de candidatos

### Setup Inicial - Empresa Admin
- [ ] Criar seed/migration para empresa admin inicial
- [ ] Criar usuário admin com role 'admin' vinculado à empresa admin
- [ ] Configurar flag 'isAdmin' na tabela companies
- [ ] Implementar lógica para questões da empresa admin serem públicas
- [ ] Criar endpoint para listar questões públicas (da empresa admin)

## Fase 2: Funcionalidades Core - Empresas

### CRUD de Test Templates
- [ ] Criar endpoint POST /api/test-templates (criar template de teste)
- [ ] **Validar que duration (duração em minutos) é obrigatório**
- [ ] **Validar que expires_at é obrigatório ao criar template**
- [ ] **Validar que expires_at é uma data futura**
- [ ] **Campo allow_resume (boolean, default false):**
  - [ ] Se true: permite pausar e continuar teste
  - [ ] Se false: teste deve ser feito de uma única vez
- [ ] Criar endpoint GET /api/test-templates (listar templates)
- [ ] Criar endpoint GET /api/test-templates/:id (detalhes do template)
- [ ] Criar endpoint PUT /api/test-templates/:id (atualizar template)
- [ ] Criar endpoint DELETE /api/test-templates/:id (deletar template)
- [ ] Validar permissões (apenas empresa dona pode editar)
- [ ] Implementar filtros (status, linguagem, data)
- [ ] **Implementar filtro por templates expirados/ativos**

### Gerenciamento de Questões no Template
- [ ] Criar endpoint POST /api/test-templates/:id/questions (adicionar questão ao template)
- [ ] Criar endpoint DELETE /api/test-templates/:id/questions/:questionId (remover questão)
- [ ] Criar endpoint PUT /api/test-templates/:id/questions/order (reordenar questões)
- [ ] Permitir adicionar questões da empresa admin aos templates
- [ ] Validar que questões pertencem à empresa ou são públicas

### Geração de Instâncias de Teste
- [ ] Criar endpoint POST /api/test-templates/:id/instances (gerar instância para candidato)
  - [ ] **Requer autenticação de empresa (JWT)**
  - [ ] Receber candidate_name (obrigatório)
  - [ ] Receber candidate_email (opcional)
  - [ ] Receber link_expires_at (obrigatório - expiração do link)
  - [ ] Validar que template não está expirado
  - [ ] Validar que link_expires_at é data futura
  - [ ] Gerar token único e seguro criptograficamente (usar rand ou uuid crate)
  - [ ] Criar instância com status 'pending'
  - [ ] Retornar link único completo para o candidato
- [ ] Criar endpoint GET /api/test-templates/:id/instances (listar instâncias do template)
  - [ ] **Requer autenticação de empresa (JWT)**
  - [ ] Retornar lista com: candidato, link, status, link_expires_at, started_at, expires_at
  - [ ] Incluir tempo restante até expiração do link
  - [ ] Incluir tempo restante do teste (se iniciado)
- [ ] Criar endpoint GET /api/test-instances/:token (acessar instância via link único)
  - [ ] **NÃO requer autenticação - acesso público via token**
  - [ ] Validar token único
  - [ ] **Validar que link não expirou (link_expires_at)**
  - [ ] **Retornar erro 410 (Gone) se link expirado**
  - [ ] **Verificar modo do teste (allow_resume do template)**
  - [ ] Se primeira vez acessando (status = pending):
    - [ ] Iniciar timer (started_at = NOW())
    - [ ] Calcular expires_at baseado em started_at + duration
    - [ ] **Atualizar status para 'in_progress'**
    - [ ] Se allow_resume = true, criar estados iniciais vazios
  - [ ] Se já iniciado (status = in_progress) e allow_resume = true:
    - [ ] Carregar estado salvo (código digitado por questão)
    - [ ] Calcular tempo restante considerando pausas
  - [ ] Se status = completed ou ai_reviewed:
    - [ ] Retornar apenas visualização (read-only)
    - [ ] Não permitir edição ou novas submissões
  - [ ] Retornar dados da instância, questões, estado salvo (se aplicável) e status atual
- [ ] **Implementar lógica de expiração de instâncias**
  - [ ] Verificar link_expires_at antes de permitir acesso
  - [ ] Verificar expires_at ao acessar instância (após iniciar)
  - [ ] Bloquear novas submissões após expiração da instância
  - [ ] **Quando tempo expira ou candidato finaliza:**
    - [ ] Atualizar status para 'completed'
    - [ ] Definir completed_at = NOW()
    - [ ] Bloquear novas submissões
- [ ] **Implementar transições de status:**
  - [ ] pending → in_progress (ao acessar pela primeira vez)
  - [ ] in_progress → completed (ao expirar tempo ou finalizar manualmente)
  - [ ] completed → ai_reviewed (após análise de IA - futuro)
  - [ ] Validar transições (não permitir voltar para estados anteriores)

### Biblioteca de Questões Compartilhadas
- [ ] Criar endpoint GET /api/questions/public (questões da empresa admin)
- [ ] Filtrar questões por linguagem
- [ ] Mostrar apenas questões publicadas pela empresa admin
- [ ] Permitir empresas visualizarem questões públicas
- [ ] Implementar busca e filtros na biblioteca

### CRUD de Questões
- [ ] Criar endpoint POST /api/questions (criar questão) - apenas empresa admin inicialmente
- [ ] Criar endpoint PUT /api/questions/:id (atualizar questão) - apenas empresa admin
- [ ] Criar endpoint DELETE /api/questions/:id (deletar questão) - apenas empresa admin
- [ ] Validar que questão pertence à empresa admin (para questões públicas)
- [ ] Implementar ordenação de questões
- [ ] Adicionar flag 'isPublic' para questões compartilhadas
- [ ] Permitir empresa admin publicar/despublicar questões

### CRUD de Casos de Teste
- [ ] Criar endpoint POST /api/questions/:id/test-cases (adicionar caso)
- [ ] Criar endpoint PUT /api/test-cases/:id (atualizar caso)
- [ ] Criar endpoint DELETE /api/test-cases/:id (deletar caso)
- [ ] Implementar flag isHidden para casos ocultos
- [ ] Validar formato de input/output

## Fase 3: Sistema de Execução de Código

### Infraestrutura de Execução
- [ ] Criar serviço de execução de código
- [ ] Implementar execução segura com Docker
- [ ] Configurar timeout de execução
- [ ] Implementar limite de memória e CPU
- [ ] Criar isolamento entre execuções

### Executor Python
- [ ] Criar container Docker para Python
- [ ] Implementar execução de código Python
- [ ] Capturar stdout/stderr
- [ ] Implementar timeout
- [ ] Validar imports permitidos (segurança)

### Executor Java
- [ ] Criar container Docker para Java
- [ ] Implementar compilação e execução
- [ ] Capturar erros de compilação
- [ ] Implementar timeout
- [ ] Validar imports permitidos

### Executor SQL
- [ ] Criar container Docker para PostgreSQL
- [ ] Implementar execução de queries SQL
- [ ] Comparar resultados de queries
- [ ] Validar queries perigosas (DROP, DELETE sem WHERE, etc)
- [ ] Implementar schema de teste isolado

### Validação de Testes
- [ ] Criar sistema de comparação de outputs
- [ ] Implementar execução de casos de teste públicos
- [ ] Implementar execução de casos de teste ocultos
- [ ] Comparar outputs (exato e normalizado)
- [ ] Gerar relatório de resultados

## Fase 4: Funcionalidades para Candidatos

### Visualização de Instâncias de Teste (Candidato)
- [ ] Criar endpoint GET /api/test-instances/:token (acessar instância via link)
- [ ] **NÃO requer autenticação - acesso público via token único**
- [ ] **Validar que link não expirou (link_expires_at)**
- [ ] **Retornar erro 410 (Gone) se link expirado antes de iniciar**
- [ ] **Validar que template não está expirado (não pode gerar novos links)**
- [ ] **Verificar allow_resume do template**
- [ ] **Se primeira vez acessando (status = pending), iniciar timer da instância**
  - [ ] Definir started_at = NOW()
  - [ ] Calcular expires_at = started_at + duration (do template)
  - [ ] **Atualizar status para 'in_progress'**
  - [ ] Registrar transição de status (audit log opcional)
  - [ ] Se allow_resume = true, criar estados iniciais vazios para cada questão
- [ ] **Se allow_resume = true e já iniciado:**
  - [ ] Carregar estado salvo (código digitado por questão)
  - [ ] Calcular tempo restante considerando pausas (expires_at - total_paused_time)
  - [ ] Se estava pausado, retomar timer
- [ ] **Se allow_resume = false:**
  - [ ] Timer sempre ativo (não pausa)
  - [ ] Calcular tempo restante baseado em expires_at
- [ ] **Retornar erro 410 (Gone) se instância expirada (após iniciar)**
- [ ] **Se status = completed ou ai_reviewed:**
  - [ ] Retornar apenas visualização (read-only)
  - [ ] Mostrar mensagem que teste foi finalizado
  - [ ] Não permitir edição ou novas submissões
- [ ] Retornar questões do template (ordem preservada)
- [ ] Retornar estado salvo (código digitado) se allow_resume = true
- [ ] Filtrar casos de teste ocultos para candidatos
- [ ] Mostrar apenas informações públicas
- [ ] **Incluir tempo restante na resposta**
- [ ] **Incluir allow_resume na resposta**
- [ ] **Incluir status atual na resposta**

### Submissão de Código
- [ ] Criar endpoint POST /api/test-instances/:token/submissions (submeter código)
- [ ] **NÃO requer autenticação - acesso público via token único**
- [ ] **Validar token único da instância**
- [ ] **Validar que status é 'in_progress' (não permite submeter se completed ou ai_reviewed)**
- [ ] **Validar que instância não está expirada antes de aceitar submissão**
- [ ] **Validar tempo restante da instância (considerando pausas se allow_resume = true)**
- [ ] **Retornar erro 410 (Gone) se instância expirada**
- [ ] **Retornar erro 400 (Bad Request) se status não permite submissão**
- [ ] Validar código antes de executar
- [ ] Executar código em sandbox
- [ ] Executar casos de teste públicos
- [ ] Salvar resultados no banco (vinculado a test_instance_id)
- [ ] Retornar status e resultados ao candidato
- [ ] **Verificar se todas as questões foram respondidas:**
  - [ ] Se sim, opcionalmente marcar como completed (ou deixar candidato finalizar manualmente)

### Salvamento de Estado (quando allow_resume = true)
- [ ] Criar endpoint POST /api/test-instances/:token/state (salvar estado do teste)
  - [ ] **NÃO requer autenticação - acesso público via token único**
  - [ ] Receber código digitado por questão
  - [ ] Receber questão atual
  - [ ] Salvar/atualizar estado no banco (test_instance_states)
  - [ ] Atualizar last_updated_at
- [ ] Criar endpoint GET /api/test-instances/:token/state (obter estado salvo)
  - [ ] **NÃO requer autenticação - acesso público via token único**
  - [ ] Retornar código digitado por questão
  - [ ] Retornar questão atual
  - [ ] Retornar progresso geral
- [ ] **Auto-save no frontend:**
  - [ ] Salvar código automaticamente a cada X segundos (debounce)
  - [ ] Salvar ao mudar de questão
  - [ ] Salvar ao sair da página (beforeunload)

### Controle de Pausa/Retomada (quando allow_resume = true)
- [ ] Criar endpoint POST /api/test-instances/:token/pause (pausar teste)
  - [ ] **NÃO requer autenticação - acesso público via token único**
  - [ ] Validar que teste permite pausa (allow_resume = true)
  - [ ] Salvar estado atual antes de pausar
  - [ ] Definir paused_at = NOW()
  - [ ] Pausar timer (não contar tempo enquanto pausado)
- [ ] Criar endpoint POST /api/test-instances/:token/resume (retomar teste)
  - [ ] **NÃO requer autenticação - acesso público via token único**
  - [ ] Validar que teste estava pausado
  - [ ] Calcular tempo pausado (NOW() - paused_at)
  - [ ] Adicionar ao total_paused_time
  - [ ] Definir resumed_at = NOW()
  - [ ] Limpar paused_at
  - [ ] Retomar timer
- [ ] **Auto-pause no frontend:**
  - [ ] Detectar quando candidato sai da página (visibilitychange, beforeunload)
  - [ ] Pausar automaticamente se allow_resume = true
  - [ ] Retomar automaticamente ao voltar

### Histórico de Submissões
- [ ] Criar endpoint GET /api/test-instances/:token/submissions (listar submissões do candidato)
  - [ ] **NÃO requer autenticação - acesso via token único**
- [ ] Criar endpoint GET /api/submissions/:id (detalhes)
  - [ ] **Validar que submissão pertence à instância do token**
- [ ] Filtrar por instância (via token)
- [ ] Mostrar status, tempo de execução, resultados

## Fase 5: Sistema de Revisão de Código

### Visualização de Submissões (Empresa)
- [ ] Criar endpoint GET /api/test-templates/:id/submissions (submissões de todas as instâncias do template)
  - [ ] **Requer autenticação de empresa (JWT)**
  - [ ] **Filtrar por status da instância (pending, in_progress, completed, ai_reviewed)**
- [ ] Criar endpoint GET /api/test-instances/:id/submissions (submissões de uma instância específica)
  - [ ] **Requer autenticação de empresa (JWT)**
- [ ] Filtrar por candidato (nome/email), questão, status da instância, instância
- [ ] Mostrar código completo com syntax highlighting
- [ ] Mostrar informações da instância (candidato nome/email, tempo restante, status atual)
- [ ] **Mostrar badge visual do status:**
  - [ ] Criado (pending) - azul
  - [ ] Em andamento (in_progress) - amarelo
  - [ ] Concluído (completed) - verde
  - [ ] Revisado pela IA (ai_reviewed) - roxo

### Code Review
- [ ] Criar endpoint POST /api/reviews (criar revisão)
- [ ] Criar endpoint GET /api/reviews/:id (detalhes da revisão)
- [ ] Criar endpoint POST /api/reviews/:id/comments (adicionar comentário)
- [ ] Implementar comentários por linha de código
- [ ] Implementar sistema de rating (1-5)
- [ ] Salvar comentários e avaliações

### Interface de Revisão
- [ ] Visualizar código com numeração de linhas
- [ ] Adicionar comentários clicando na linha
- [ ] Ver histórico de comentários
- [ ] Comparar múltiplas submissões

## Fase 6: Frontend - Setup e Autenticação

### Setup Frontend
- [ ] Criar projeto Next.js 14 com TypeScript
- [ ] Configurar estrutura de pastas (components, pages, hooks, utils)
- [ ] Configurar Tailwind CSS ou styled-components
- [ ] Configurar roteamento
- [ ] Configurar gerenciamento de estado (Context API ou Zustand)

### Autenticação Frontend
- [ ] Criar página de login (apenas empresas)
- [ ] Criar página de registro (apenas empresas)
- [ ] Implementar contexto de autenticação (apenas empresas)
- [ ] Criar hook useAuth (apenas empresas)
- [ ] Implementar proteção de rotas (apenas para área de empresas)
- [ ] Criar componente de header/navbar
- [ ] **Rotas de candidatos:**
  - [ ] Não requerem autenticação
  - [ ] Acesso direto via link único
  - [ ] Validar token no frontend (opcional, validação real no backend)

## Fase 7: Frontend - Dashboard Empresa

### Dashboard Principal
- [ ] Criar página de dashboard da empresa
- [ ] Listar templates de testes criados
- [ ] **Mostrar status de expiração do template (ativo/expirado/próximo de expirar)**
- [ ] **Exibir contador regressivo para templates próximos de expirar**
- [ ] **Badge visual para templates expirados**
- [ ] Estatísticas básicas (total de templates, instâncias geradas, candidatos, etc)
- [ ] **Estatística: templates expirados vs ativos**
- [ ] **Estatística: instâncias por status**
- [ ] Filtros e busca
- [ ] **Filtro por status de expiração**
- [ ] **Link para gerenciar instâncias de cada template**

### Criação de Test Templates
- [ ] Criar página/formulário de criação de template de teste
- [ ] Campos: título, descrição, linguagem
- [ ] **Campo obrigatório: duração do teste (em minutos)**
- [ ] **Campo obrigatório: data e hora de expiração do template**
- [ ] **Validador de data futura para expiração**
- [ ] **Seletor de data/hora com calendário**
- [ ] **Campo: Modo de execução do teste:**
  - [ ] Radio button ou toggle: "De uma única vez" vs "Permitir pausar e continuar"
  - [ ] Se "De uma única vez": allow_resume = false
  - [ ] Se "Permitir pausar e continuar": allow_resume = true
  - [ ] Explicação de cada modo para empresa
- [ ] **Seletor de múltiplas questões:**
  - [ ] Biblioteca de questões públicas (empresa admin)
  - [ ] Questões próprias (quando disponível)
  - [ ] Drag and drop para ordenar questões
  - [ ] Preview das questões selecionadas
- [ ] Validação de formulário
- [ ] Preview do template
- [ ] Mostrar questões selecionadas antes de salvar

### Geração de Links para Candidatos
- [ ] Criar página de gerenciamento de instâncias do template
- [ ] **Formulário para gerar link único:**
  - [ ] Campo: nome do candidato (obrigatório)
  - [ ] Campo: email do candidato (opcional)
  - [ ] Campo: expiração do link (data/hora - obrigatório)
  - [ ] Validador: expiração deve ser data futura
  - [ ] Botão: Gerar link único
- [ ] **Lista/tabela de todas as instâncias geradas:**
  - [ ] Colunas: Nome do Candidato, Email, Link, Status, Expiração do Link, Tempo Restante do Teste
  - [ ] **Mostrar status visual (badge) com cores:**
    - [ ] Criado (pending) - azul claro
    - [ ] Em andamento (in_progress) - amarelo/laranja
    - [ ] Concluído (completed) - verde
    - [ ] Revisado pela IA (ai_reviewed) - roxo
    - [ ] Link Expirado - cinza (link_expires_at passou e status ainda pending)
  - [ ] Botão "Copiar Link" em cada linha
  - [ ] **Filtros: por status (pending, in_progress, completed, ai_reviewed), por candidato (busca)**
  - [ ] Ordenação: por data de criação, por status, por candidato
- [ ] **Visualizar status de cada instância:**
  - [ ] Criado (pending) - link gerado, não iniciado
  - [ ] Link expirado - link_expires_at passou e status ainda pending
  - [ ] Em andamento (in_progress) - teste iniciado
  - [ ] Concluído (completed) - teste finalizado
  - [ ] Revisado pela IA (ai_reviewed) - análise de IA concluída
- [ ] **Ações por status:**
  - [ ] pending/in_progress: Copiar link, Ver detalhes
  - [ ] completed: Ver submissões, Solicitar revisão IA
  - [ ] ai_reviewed: Ver submissões, Ver revisão IA, Revisar manualmente
- [ ] **Ações disponíveis:**
  - [ ] Copiar link único (botão de copiar)
  - [ ] Visualizar detalhes da instância
  - [ ] Ver submissões (se houver)
  - [ ] Regenerar link (opcional - criar nova instância)

### Gerenciamento de Questões
- [ ] Criar página de questões de um teste
- [ ] Criar biblioteca de questões públicas (empresa admin)
- [ ] Permitir selecionar questões da biblioteca para adicionar ao teste
- [ ] Adicionar/editar/deletar questões próprias (quando disponível)
- [ ] Editor de código para starter code
- [ ] Drag and drop para ordenar questões
- [ ] Visualizar origem da questão (admin vs própria)

### Gerenciamento de Casos de Teste
- [ ] Criar interface para adicionar casos de teste
- [ ] Campos: input, output esperado, flag oculto
- [ ] Listar casos de teste
- [ ] Editar/deletar casos

## Fase 8: Frontend - Interface do Candidato

### Visualização de Instâncias (Candidato)
- [ ] **Candidato acessa via link único recebido (sem login necessário)**
- [ ] **Não há listagem pública - apenas acesso via link**
- [ ] **Não há página de login para candidatos**
- [ ] Página de acesso ao teste:
  - [ ] Extrair token do link (query param ou path)
  - [ ] Validar token do link (chamada API sem autenticação)
  - [ ] Se primeira vez, mostrar modal de início
  - [ ] Se já iniciado, mostrar timer e questões
- [ ] **Mostrar tempo restante da instância individual**
- [ ] **Contador regressivo em tempo real**
- [ ] **Aviso visual quando tempo está próximo de acabar (< 5 minutos)**
- [ ] Mostrar questões do teste (ordem definida no template)

### Editor de Código
- [ ] Integrar editor de código (Monaco Editor ou CodeMirror)
- [ ] Syntax highlighting por linguagem
- [ ] Auto-complete básico
- [ ] Numeração de linhas
- [ ] Tema claro/escuro

### Resolução de Questões (Candidato)
- [ ] Criar página de acesso via link único
- [ ] **Ao acessar link pela primeira vez:**
  - [ ] Modal de confirmação para iniciar teste
  - [ ] Explicar que tempo começará a contar
  - [ ] **Mostrar modo do teste (contínuo ou com pausa)**
  - [ ] Botão "Iniciar Teste" que inicia o timer
- [ ] **Página principal do teste:**
  - [ ] **Timer individual no topo (contador regressivo)**
  - [ ] **Mostrar tempo restante baseado na instância**
  - [ ] **Indicador visual do modo (contínuo ou com pausa)**
  - [ ] Lista de questões do teste
  - [ ] Navegação entre questões
  - [ ] **Se allow_resume = true:**
    - [ ] Botão "Pausar" (opcional, auto-pause ao sair)
    - [ ] Indicador de estado (em andamento, pausado)
- [ ] Página de questão individual:
  - [ ] **Verificar se instância não expirou antes de permitir edição**
  - [ ] **Mostrar timer no topo da página**
  - [ ] **Desabilitar botão de submeter se instância expirou**
  - [ ] Mostrar descrição e starter code
  - [ ] Editor de código integrado
  - [ ] **Se allow_resume = true:**
    - [ ] **Carregar código salvo automaticamente ao abrir questão**
    - [ ] **Auto-save do código (debounce a cada 3-5 segundos)**
    - [ ] **Indicador visual de "Salvando..." / "Salvo"**
    - [ ] **Salvar ao mudar de questão**
    - [ ] **Salvar ao sair da página (beforeunload)**
  - [ ] Botão de submeter
  - [ ] Loading state durante execução
  - [ ] **Notificação quando tempo está próximo de acabar (< 5 minutos)**
  - [ ] **Modal de aviso quando tempo expira durante resolução**
- [ ] **Gerenciamento de pausa (se allow_resume = true):**
  - [ ] Detectar quando candidato sai da página (visibilitychange)
  - [ ] Pausar automaticamente ao sair
  - [ ] Retomar automaticamente ao voltar
  - [ ] Mostrar mensagem "Teste pausado" quando fora da página
  - [ ] Continuar de onde parou ao retornar
- [ ] **Finalização do teste:**
  - [ ] Botão "Finalizar Teste" (opcional - ou finalizar automaticamente ao expirar)
  - [ ] Ao finalizar ou expirar tempo:
    - [ ] Atualizar status para 'completed'
    - [ ] Definir completed_at = NOW()
    - [ ] Bloquear novas submissões
    - [ ] Mostrar tela de conclusão
    - [ ] Exibir resultados finais

### Resultados
- [ ] Mostrar resultados após submissão
- [ ] Listar casos de teste que passaram/falharam
- [ ] Mostrar outputs esperados vs recebidos
- [ ] Mostrar erros de compilação/execução
- [ ] Tempo de execução

## Fase 9: Frontend - Sistema de Revisão

### Lista de Submissões (Empresa)
- [ ] Criar página de submissões de um teste
- [ ] Filtrar por candidato, questão, status
- [ ] Tabela com informações resumidas
- [ ] Link para revisão detalhada

### Interface de Revisão
- [ ] Criar página de revisão de código
- [ ] Visualizar código com syntax highlighting
- [ ] Adicionar comentários clicando nas linhas
- [ ] Modal/formulário de comentário
- [ ] Sistema de rating (estrelas)
- [ ] Salvar revisão

### Comparação de Códigos
- [ ] Visualizar múltiplas submissões lado a lado
- [ ] Comparar diferentes soluções
- [ ] Filtros e ordenação

## Fase 10: Melhorias e Polimento

### Performance
- [ ] Otimizar queries do banco de dados
- [ ] Implementar cache onde necessário
- [ ] Otimizar bundle do frontend
- [ ] Lazy loading de componentes

### UX/UI
- [ ] Melhorar design e responsividade
- [ ] Adicionar animações e transições
- [ ] Melhorar feedback visual (toasts, loading states)
- [ ] Criar componentes reutilizáveis
- [ ] Implementar dark mode

### Segurança
- [ ] Validar todos os inputs
- [ ] Sanitizar código antes de executar
- [ ] Implementar rate limiting
- [ ] Adicionar CORS adequado
- [ ] Revisar vulnerabilidades de segurança
- [ ] **Validar expiração no backend (não confiar apenas no frontend)**
- [ ] **Prevenir manipulação de expires_at via API**

### Testes
- [ ] Criar testes unitários para backend
- [ ] Criar testes de integração para APIs
- [ ] Criar testes E2E para fluxos principais
- [ ] Testar execução de código em diferentes cenários

### Documentação
- [x] Documentar APIs (Swagger/OpenAPI) - OpenAPI 3.0.3 criado (backend/openapi.yaml)
- [x] Criar README completo - README.md com instruções de uso
- [x] Documentar setup e deploy - Instruções Docker no README
- [x] Swagger UI configurado - docker-compose.swagger.yml para visualizar OpenAPI
- [ ] Criar guia de contribuição

### Deploy
- [ ] Configurar CI/CD
- [ ] Preparar ambiente de produção
- [ ] Configurar variáveis de ambiente
- [ ] Deploy do backend
- [ ] Deploy do frontend
- [ ] Configurar domínio e SSL

## Priorização Sugerida

**MVP (Mínimo Produto Viável):**
1. Fase 1: Setup completo
2. Fase 2: CRUD básico de testes e questões
3. Fase 3: Execução de código (Python primeiro)
4. Fase 4: Submissão básica
5. Fase 6: Frontend básico com autenticação
6. Fase 7: Dashboard empresa básico
7. Fase 8: Interface candidato básica

**V2 (Melhorias):**
- Fase 3: Adicionar Java e SQL
- Fase 5: Sistema de revisão completo
- Fase 9: Interface de revisão
- Fase 10: Polimento e otimizações

**V3 (IA e Automação):**
- Fase 11: Agente de IA para revisão automática de código

**V4 (Monitoramento e Proctoring):**
- Fase 12: Sistema de monitoramento de comportamento durante testes

## Notas Importantes

- Começar sempre pelo backend antes do frontend
- Testar execução de código extensivamente antes de produção
- Segurança é crítica - código de usuários não pode comprometer o sistema
- Performance da execução de código é importante para UX
- Considerar fila de jobs para execuções (Redis + Bull) se houver muitos usuários
- **Duração do teste é obrigatória** - todos os templates devem ter duração definida (em minutos)
- **Período de expiração do template é obrigatório** - define até quando pode gerar novos links
- **Cada candidato recebe instância única** - link exclusivo, tempo individual, status independente
- **Timer individual inicia no primeiro acesso** - tempo começa quando candidato acessa o link pela primeira vez
- **Validação de expiração deve ser feita no backend** - nunca confiar apenas no frontend
- **Tokens de link devem ser seguros** - usar tokens criptograficamente seguros (não sequenciais, não previsíveis)
- **Candidatos não precisam de conta** - acesso direto via link único, sem autenticação
- **Links têm expiração própria** - empresa define quando o link expira ao gerá-lo
- **Empresa gerencia links no frontend** - lista de testes com dados dos candidatos
- **Empresa envia links por conta própria** - sistema não envia emails/SMS, empresa copia e envia como quiser
- **Backend em Rust** - escolhido para redução de custos (menor uso de recursos, melhor performance)
- Considerar job periódico para marcar instâncias como expiradas (cron job)
- Notificações de tempo podem melhorar UX (avisar candidatos quando tempo está acabando)
- **Salvar progresso automaticamente** - permitir que candidato volte e continue de onde parou (dentro do tempo)
- **Rust oferece vantagens:**
  - Menor uso de memória e CPU (redução de custos de infraestrutura)
  - Melhor performance e concorrência
  - Segurança de memória em tempo de compilação
  - Binário otimizado e eficiente

## Fase 11: Agente de IA para Revisão Automática (Futuro)

### Integração com API de IA
- [ ] Escolher provedor de IA (OpenAI GPT-4, Claude, ou similar)
- [ ] Configurar API key e variáveis de ambiente
- [ ] Criar serviço de integração com API de IA
- [ ] Implementar tratamento de erros e retry logic
- [ ] Configurar rate limiting para API de IA

### Serviço de Análise de Código
- [ ] Criar serviço de análise de código por IA
- [ ] Preparar prompt engineering para análise de código
- [ ] Implementar análise de diferentes linguagens (Python, Java, SQL)
- [ ] Extrair contexto da questão e casos de teste
- [ ] Enviar código + contexto para API de IA

### Funcionalidades do Agente de IA
- [ ] Análise de qualidade do código
  - [ ] Legibilidade e clareza
  - [ ] Estrutura e organização
  - [ ] Nomenclatura de variáveis e funções
  - [ ] Comentários e documentação
- [ ] Análise de boas práticas
  - [ ] Padrões de design aplicados
  - [ ] Otimização e performance
  - [ ] Tratamento de erros
  - [ ] Segurança (SQL injection, etc)
- [ ] Sugestões de melhoria
  - [ ] Refatoração sugerida
  - [ ] Otimizações possíveis
  - [ ] Correções de bugs potenciais
- [ ] Geração de feedback estruturado
  - [ ] Pontos positivos
  - [ ] Pontos de melhoria
  - [ ] Sugestão de rating (1-5)
  - [ ] Comentários por seção do código

### Endpoints de IA
- [ ] Criar endpoint POST /api/test-instances/:id/ai-review (solicitar revisão de toda instância)
  - [ ] **Requer autenticação de empresa (JWT)**
  - [ ] Validar que instância está completed
  - [ ] Iniciar processo de revisão assíncrono
- [ ] Criar endpoint POST /api/submissions/:id/ai-review (solicitar revisão de submissão específica)
- [ ] Criar endpoint GET /api/submissions/:id/ai-review (obter revisão)
- [ ] Implementar processamento assíncrono (fila de jobs)
- [ ] Retornar status da revisão (pending, processing, completed, failed)
- [ ] Armazenar revisões da IA no banco de dados
- [ ] **Após revisão completa de todas as submissões:**
  - [ ] Atualizar status da instância para 'ai_reviewed'
  - [ ] Definir ai_reviewed_at = NOW()
  - [ ] Notificar empresa (opcional)

### Armazenamento de Revisões IA
- [ ] Criar tabela ai_reviews no banco de dados
- [ ] Campos: submission_id, analysis, suggestions, rating, created_at
- [ ] Criar tabela ai_review_comments (comentários por linha/seção)
- [ ] Relacionar com tabela de code_reviews existente

### Interface de Revisão IA
- [ ] Criar componente para exibir revisão da IA
- [ ] Mostrar análise geral e rating sugerido
- [ ] Exibir comentários da IA no código (linhas específicas)
- [ ] Permitir aceitar/rejeitar sugestões da IA
- [ ] Permitir editar comentários da IA antes de salvar
- [ ] Comparar revisão manual vs revisão IA
- [ ] Histórico de revisões IA para uma submissão

### Melhorias e Aprendizado
- [ ] Coletar feedback sobre qualidade das revisões IA
- [ ] Ajustar prompts baseado em feedback
- [ ] Implementar fine-tuning do modelo (se possível)
- [ ] Métricas de acurácia das revisões IA
- [ ] Sistema de aprendizado com revisões manuais

### Considerações Técnicas
- [ ] Custos de API de IA (monitorar uso)
- [ ] Tempo de resposta (pode ser assíncrono)
- [ ] Limites de tokens por revisão
- [ ] Cache de revisões similares
- [ ] Fallback quando IA não disponível

## Fase 12: Sistema de Monitoramento de Comportamento (Futuro)

### Infraestrutura de Tracking
- [ ] Criar serviço de tracking de eventos no frontend
- [ ] Implementar biblioteca de eventos (ou usar biblioteca existente)
- [ ] Configurar coleta de eventos em tempo real
- [ ] Implementar buffer local para eventos (offline support)
- [ ] Criar endpoint para envio de eventos em batch

### Eventos a Rastrear
- [ ] **Eventos de navegação:**
  - [ ] Mudança de questão (qual questão, quando)
  - [ ] Tempo gasto em cada questão
  - [ ] Número de vezes que voltou para uma questão
- [ ] **Eventos de foco/janela:**
  - [ ] Mudança de aba (blur/focus)
  - [ ] Mudança de janela
  - [ ] Tempo fora da aba/janela
  - [ ] Número de mudanças de aba
- [ ] **Eventos de interação:**
  - [ ] Cliques no editor
  - [ ] Eventos de teclado (digitação, atalhos)
  - [ ] Scroll na página
  - [ ] Copiar/colar (detectar Ctrl+C, Ctrl+V)
  - [ ] Seleção de texto
- [ ] **Eventos de código:**
  - [ ] Mudanças no código (digitação, edição)
  - [ ] Tempo entre edições
  - [ ] Padrões de digitação (velocidade, pausas)
- [ ] **Eventos de submissão:**
  - [ ] Tentativas de submissão
  - [ ] Tempo antes de submeter
  - [ ] Mudanças após primeira submissão

### Armazenamento de Eventos
- [ ] Criar tabela activity_logs no banco de dados
- [ ] Campos: id, test_instance_id, event_type, event_data (JSONB), timestamp, metadata
- [ ] Índices para queries rápidas:
  - [ ] Índice em test_instance_id
  - [ ] Índice em event_type
  - [ ] Índice em timestamp
- [ ] Implementar compressão/agregação de eventos antigos
- [ ] Considerar armazenamento em time-series database (opcional)

### Endpoints de Tracking
- [ ] Criar endpoint POST /api/test-instances/:token/events (enviar eventos)
  - [ ] **NÃO requer autenticação - acesso via token único**
  - [ ] Aceitar eventos em batch
  - [ ] Validar token da instância
  - [ ] Validar formato dos eventos
  - [ ] Salvar eventos no banco
- [ ] Criar endpoint GET /api/test-instances/:id/events (obter eventos de uma instância)
  - [ ] **Requer autenticação de empresa (JWT)**
  - [ ] Filtrar por tipo de evento
  - [ ] Filtrar por período
  - [ ] Retornar timeline de eventos
- [ ] Criar endpoint GET /api/test-instances/:id/activity-summary (resumo de atividade)
  - [ ] **Requer autenticação de empresa (JWT)**
  - [ ] Agregar eventos por tipo
  - [ ] Calcular métricas (tempo total, mudanças de aba, etc)
  - [ ] Retornar estatísticas

### Detecção de Comportamento Suspeito
- [ ] **Algoritmos de detecção:**
  - [ ] Muitas mudanças de aba (> X vezes)
  - [ ] Tempo excessivo fora da aba (> Y segundos)
  - [ ] Padrões de digitação anômalos (muito rápido, muito lento)
  - [ ] Muitas operações de copiar/colar
  - [ ] Tempo muito curto em questões difíceis
  - [ ] Muitas tentativas de submissão em pouco tempo
- [ ] **Sistema de scoring de risco:**
  - [ ] Calcular score de risco baseado em eventos
  - [ ] Alertar empresa se score acima do threshold
  - [ ] Marcar instância com flag de "comportamento suspeito"
- [ ] **Regras configuráveis:**
  - [ ] Permitir empresa definir thresholds
  - [ ] Configurar quais eventos são considerados suspeitos

### Interface de Monitoramento (Empresa)
- [ ] Criar página de monitoramento de instância
- [ ] **Timeline de eventos:**
  - [ ] Visualizar linha do tempo com todos os eventos
  - [ ] Filtrar por tipo de evento
  - [ ] Zoom in/out na timeline
- [ ] **Métricas e estatísticas:**
  - [ ] Tempo total gasto no teste
  - [ ] Tempo gasto por questão
  - [ ] Número de mudanças de aba
  - [ ] Tempo fora da aba
  - [ ] Número de submissões por questão
  - [ ] Gráficos de atividade ao longo do tempo
- [ ] **Alertas e flags:**
  - [ ] Badge visual para comportamento suspeito
  - [ ] Lista de eventos suspeitos destacados
  - [ ] Score de risco exibido
- [ ] **Comparação:**
  - [ ] Comparar atividade de diferentes candidatos
  - [ ] Identificar padrões anômalos

### Implementação Frontend (Tracking)
- [ ] Criar hook useActivityTracker
- [ ] Implementar listeners de eventos:
  - [ ] window blur/focus
  - [ ] visibilitychange API
  - [ ] keyboard events
  - [ ] mouse events
  - [ ] clipboard events
- [ ] **Throttling e debouncing:**
  - [ ] Limitar frequência de eventos enviados
  - [ ] Agrupar eventos similares
  - [ ] Buffer local antes de enviar
- [ ] **Otimizações:**
  - [ ] Enviar eventos em batch (a cada X segundos ou Y eventos)
  - [ ] Retry logic para eventos falhados
  - [ ] Armazenar eventos localmente se offline

### Privacidade e Transparência
- [ ] **Aviso ao candidato:**
  - [ ] Informar que atividade será monitorada
  - [ ] Explicar quais dados são coletados
  - [ ] Termo de consentimento (opcional)
- [ ] **LGPD/GDPR compliance:**
  - [ ] Permitir candidato visualizar seus próprios logs
  - [ ] Política de retenção de dados
  - [ ] Opção de exportar dados pessoais

### Análise e Relatórios
- [ ] Criar relatório de atividade por instância
- [ ] **Métricas agregadas:**
  - [ ] Média de tempo por questão
  - [ ] Taxa de mudança de aba
  - [ ] Padrões comuns de comportamento
- [ ] **Exportação:**
  - [ ] Exportar logs em CSV/JSON
  - [ ] Gerar PDF com relatório de atividade
- [ ] **Dashboard de analytics:**
  - [ ] Visão geral de todas as instâncias
  - [ ] Identificar outliers
  - [ ] Tendências e padrões

### Considerações Técnicas
- [ ] Performance: tracking não deve impactar UX
- [ ] Volume de dados: considerar estratégias de agregação
- [ ] Escalabilidade: muitos eventos simultâneos
- [ ] Privacidade: dados sensíveis, garantir segurança
- [ ] False positives: calibrar detecção para evitar alertas falsos
- [ ] Configurabilidade: permitir empresas desabilitar monitoramento

## Configuração Inicial Especial

**Empresa Admin:**
- No início, apenas uma empresa será cadastrada como admin
- Esta empresa terá permissões especiais para criar questões públicas
- Questões criadas pela empresa admin serão visíveis para todas as empresas
- Empresas podem usar questões da empresa admin em seus testes
- Empresas não podem editar questões da empresa admin (apenas usar)

**Evolução Futura:**
- Posteriormente, empresas poderão criar suas próprias questões privadas
- Sistema de permissões pode evoluir para permitir múltiplas empresas admin
- Possibilidade de marketplace de questões entre empresas
- **Agente de IA para revisão automática** - reduzir tempo de revisão manual
- **IA para geração de questões** - ajudar empresa admin a criar questões
- **IA para análise de padrões** - identificar questões problemáticas ou muito fáceis/difíceis
- **Sistema de monitoramento de comportamento** - rastrear atividades do candidato durante o teste
- **Proctoring básico** - detectar mudanças de aba, copiar/colar, e outros eventos suspeitos
