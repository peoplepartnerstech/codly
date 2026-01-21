# Codly - Plataforma de Testes de Programação

## Visão Geral

O **Codly** é uma plataforma completa para testes de programação, similar ao HackerRank, focada em processos de contratação empresariais. A plataforma permite que empresas criem testes personalizados em diferentes linguagens de programação e que candidatos resolvam questões de forma segura e eficiente.

## Modelo Inicial

No início da plataforma, haverá apenas **uma empresa administradora** cadastrada no sistema. Esta empresa terá permissões de administrador e suas questões serão **compartilhadas e visíveis para todas as outras empresas** que se cadastrarem posteriormente. Isso permite:

- Centralizar a criação de questões de qualidade
- Garantir consistência nas avaliações técnicas
- Facilitar o onboarding de novas empresas
- Permitir que empresas reutilizem questões já validadas

As empresas que se cadastrarem depois poderão:
- Visualizar e usar questões da empresa admin em seus testes
- Criar seus próprios testes personalizados usando essas questões
- Adicionar questões próprias (quando essa funcionalidade for implementada)

## Público-Alvo

### Empresas
- Empresas que precisam avaliar habilidades técnicas de candidatos
- Recrutadores que querem criar testes personalizados
- Equipes de RH que precisam revisar código de candidatos

### Candidatos
- Desenvolvedores em processos seletivos
- Profissionais que querem praticar programação
- Candidatos que precisam demonstrar suas habilidades técnicas
- **Não precisam criar conta** - acesso direto via link único fornecido pela empresa

## Funcionalidades Principais

### Para Empresas

1. **Criação de Testes Personalizados**
   - Criar testes em múltiplas linguagens (SQL, Python, Java)
   - **Adicionar múltiplas questões ao teste** (selecionar da biblioteca ou criar próprias)
   - Selecionar questões da biblioteca compartilhada (empresa admin)
   - Definir questões próprias (quando disponível)
   - Configurar código inicial (starter code) para os candidatos
   - **Definir duração do teste (tempo limite em minutos)**
   - **Configurar modo de execução do teste:**
     - **Modo contínuo (de uma única vez):** Candidato deve completar o teste sem pausar
       - Timer continua mesmo se sair da página
       - Não é possível salvar progresso e continuar depois
       - Ideal para testes com tempo limitado e rigorosos
     - **Modo com pausa (permitir continuar):** Candidato pode pausar e retomar o teste
       - Progresso é salvo automaticamente
       - Código digitado é preservado
       - Candidato pode voltar e continuar de onde parou
       - Timer pausa quando candidato sai
       - Ideal para testes mais flexíveis
   - **Definir período de expiração obrigatório do template de teste**
     - Data e hora de expiração do template (até quando pode gerar novos links)
     - Após expiração, não é possível gerar novos links para candidatos
   - **Gerar link único para cada candidato com expiração**
     - Cada candidato recebe uma instância única do teste
     - Link exclusivo e não compartilhável
     - **Link tem expiração própria** (além da expiração do template)
     - Empresa define quando o link expira ao gerá-lo
     - Tempo individual começa quando candidato acessa o link
     - Cada instância tem seu próprio período de expiração baseado no início

2. **Gerenciamento de Casos de Teste**
   - Criar casos de teste públicos (visíveis ao candidato)
   - Criar casos de teste ocultos (para validação final)
   - Definir inputs e outputs esperados
   - Organizar casos de teste por ordem de execução

3. **Revisão de Código**
   - Visualizar todas as submissões dos candidatos
   - Adicionar comentários em linhas específicas do código
   - Avaliar código com sistema de rating (1-5)
   - Comparar diferentes soluções
   - **Agente de IA para revisão automática** (futuro)
     - Revisão automática de código submetido
     - Sugestões de melhoria e boas práticas
     - Análise de complexidade e qualidade
     - Feedback sobre estilo de código

4. **Gestão de Processos**
   - Ativar/desativar testes
   - **Definir período de expiração do template (obrigatório)**
     - Data e hora de expiração do template (obrigatório ao criar teste)
     - Após expiração, não é possível gerar novos links
     - Visualizar contador regressivo até expiração do template
   - **Gerenciar instâncias de teste por candidato**
     - Gerar link único para cada candidato com expiração configurável
     - **Lista de testes com dados dos candidatos no frontend**
       - Visualizar todas as instâncias geradas em formato de lista/tabela
       - Ver informações do candidato (nome, email) associadas a cada teste
       - **Ver status de cada instância com badges visuais:**
         - Criado (pending) - link gerado, não iniciado
         - Iniciado (in_progress) - teste em andamento
         - Concluído (completed) - teste finalizado
         - Revisado pela IA (ai_reviewed) - análise de IA concluída
       - Ver expiração do link e tempo restante
       - Filtrar por status
     - Copiar link único para compartilhar com candidato
     - **Empresa envia link por conta própria** (email, WhatsApp, etc - não é responsabilidade do sistema)
     - Cada instância tem tempo individual baseado na duração do teste
   - **Monitoramento de Comportamento (Futuro)**
     - Rastrear interações do candidato durante o teste
     - Detectar mudanças de aba/janela
     - Monitorar eventos de teclado e mouse
     - Registrar tempo gasto em cada questão
     - Identificar padrões suspeitos de comportamento
     - Gerar relatório de atividade para revisão
   - Visualizar estatísticas de desempenho
   - Arquivar testes concluídos
   - Ver histórico de testes expirados

### Para Candidatos

1. **Resolução de Questões**
   - Visualizar descrição clara do problema
   - Receber código inicial quando fornecido
   - Implementar solução na linguagem especificada
   - Testar código localmente antes de submeter

2. **Submissão e Validação**
   - Submeter código para avaliação automática
   - Ver resultados em tempo real
   - Visualizar quais casos de teste passaram/falharam
   - Receber feedback sobre erros de compilação ou execução

3. **Acompanhamento**
   - Ver histórico de submissões
   - Acompanhar status de cada tentativa
   - Visualizar tempo de execução

## Linguagens Suportadas

- **Python** - Versão 3.11+
- **Java** - Versão 17+
- **SQL** - PostgreSQL 15+

## Arquitetura Técnica

### Frontend
- Framework: Next.js 14 (React + TypeScript)
- UI: Componentes modernos e responsivos
- Estado: Gerenciamento de estado global
- Autenticação: JWT tokens (apenas para empresas)
- **Acesso de candidatos:** Sem autenticação, acesso direto via link único

### Backend
- Runtime: Rust
- Framework Web: Axum
- Linguagem: Rust
- Banco de Dados: PostgreSQL (usando sqlx ou diesel)
- Autenticação: JWT com bcrypt (apenas para empresas)
- Execução de Código: Docker containers (sandbox)
- **Vantagens do Rust + Axum:**
  - Redução significativa de custos de infraestrutura
  - Melhor performance e menor uso de memória
  - Concorrência eficiente com async/await
  - Segurança de memória em tempo de compilação
  - Axum: framework moderno, ergonômico e performático
  - Integração nativa com tokio para async runtime

### Modelo de Dados
- **Test Template**: Template do teste criado pela empresa (contém questões, duração, expiração do template, modo de execução)
  - Campo `allow_resume`: define se teste pode ser pausado e continuado depois
- **Test Instance**: Instância única do teste para cada candidato (link único, tempo individual, status)
  - Candidatos não precisam ter conta - identificados apenas pelo link único
  - Informações do candidato (nome obrigatório, email opcional) fornecidas pela empresa ao gerar link
  - **Link tem expiração própria** (link_expires_at) - define até quando o link pode ser usado
  - Após expiração do link, candidato não pode mais acessar (mesmo que não tenha iniciado)
  - Campos para controle de pausa: `paused_at`, `resumed_at`, `total_paused_time`
  - **Estados do teste (status):**
    - **pending** (Criado): Link gerado, candidato ainda não acessou
    - **in_progress** (Iniciado): Candidato acessou e iniciou o teste
    - **completed** (Concluído): Candidato finalizou o teste (tempo acabou ou submeteu todas as questões)
    - **ai_reviewed** (Revisado pela IA): Teste foi analisado pelo agente de IA (futuro)
- **Test Instance State**: Estado salvo do teste (quando allow_resume = true)
  - Código digitado por questão
  - Questão atual
  - Progresso geral
  - Timestamps de última atualização
- **Questions**: Questões criadas pela empresa admin (públicas) ou empresas (privadas)
- **Submissions**: Submissões de código vinculadas à instância do teste
- **Activity Logs**: Logs de atividade do candidato durante o teste (eventos, interações, timestamps)
- **Users**: Apenas empresas têm contas no sistema

### Segurança
- Execução isolada de código em containers Docker
- Autenticação e autorização por roles (apenas empresas)
- **Acesso de candidatos:** Autenticação via token único no link (sem necessidade de conta)
- Validação de inputs
- Timeout de execução para evitar loops infinitos
- Links únicos com tokens seguros criptograficamente (não sequenciais, não previsíveis)
- **Monitoramento de integridade do teste (futuro)**
  - Detecção de mudança de aba/janela
  - Rastreamento de eventos suspeitos
  - Logs de atividade para auditoria

## Diferenciais

1. **Foco em Contratação**: Plataforma específica para processos seletivos
2. **Revisão de Código**: Sistema completo de code review integrado
3. **Agente de IA**: Revisão automática inteligente de código (futuro)
4. **Flexibilidade**: Empresas criam seus próprios testes e casos de teste
5. **Segurança**: Execução isolada garante segurança do sistema
6. **Simplicidade**: Interface intuitiva para ambos os públicos

## Fluxo de Uso

### Empresa criando um teste:
1. **Login/Registro como empresa (necessário ter conta)**
2. Criar novo teste template (definir linguagem, título, descrição)
3. **Definir duração do teste (tempo limite em minutos)**
4. **Definir data e hora de expiração do template (obrigatório)**
5. **Adicionar múltiplas questões ao teste:**
   - Selecionar questões da biblioteca compartilhada (empresa admin)
   - Adicionar questões próprias (quando disponível)
   - Ordenar questões no teste
6. Para questões próprias: criar casos de teste (públicos e ocultos)
7. Ativar o teste template
8. **Gerar link único para cada candidato:**
   - Informar nome do candidato (obrigatório para identificação)
   - Informar email do candidato (opcional, apenas para identificação)
   - **Definir expiração do link** (até quando o link pode ser usado)
   - Sistema gera link exclusivo com token seguro
   - Cada link cria uma instância única do teste
   - **Candidato não precisa criar conta** - acesso direto via link
9. **Visualizar lista de testes com dados dos candidatos:**
   - Lista/tabela mostrando todos os testes gerados
   - Colunas: candidato, link, status, expiração do link, tempo restante
   - Filtros e busca por candidato
   - Copiar link para compartilhar
10. **Enviar link para candidato:**
    - Empresa copia link e envia por conta própria (email, WhatsApp, etc)
    - Sistema não envia links automaticamente
11. **Monitorar instâncias:**
    - Ver status de cada instância (não iniciada, em andamento, concluída)
    - Visualizar tempo restante de cada candidato
    - Ver submissões por instância
    - Ver se link expirou antes de ser usado

### Empresa Admin criando questões:
1. Login como empresa admin
2. Criar nova questão (definir linguagem, título, descrição)
3. Adicionar casos de teste (públicos e ocultos)
4. Publicar questão (disponível para todas as empresas)

### Candidato resolvendo:
1. **Acessar teste via link único recebido (sem necessidade de criar conta)**
2. **Ao acessar pela primeira vez:**
   - **Aviso sobre monitoramento de atividade (quando disponível)**
   - **Verificar se teste permite continuar ou deve ser feito de uma vez**
   - Inicia o timer individual automaticamente
   - Tempo começa a contar a partir do primeiro acesso
   - Duração baseada no tempo definido no teste template
   - **Não precisa fazer login ou criar conta**
3. **Comportamento do timer baseado no modo do teste:**
   - **Modo contínuo (de uma única vez):**
     - Timer continua mesmo se sair e voltar
     - Não é possível pausar
     - Tempo continua contando independente de estar na página
   - **Modo com pausa (permitir continuar):**
     - Timer pausa quando candidato sai da página
     - Progresso e código são salvos automaticamente
     - Ao voltar, pode continuar de onde parou
     - Timer retoma de onde parou
4. **Visualizar tempo restante do seu teste individual**
   - Contador regressivo mostra tempo restante
   - Em modo contínuo: timer sempre ativo
   - Em modo com pausa: timer pausa quando sai
5. Navegar entre questões do teste
6. Para cada questão:
   - Ler descrição do problema
   - Implementar solução no editor
   - **Código é salvo automaticamente (em modo com pausa)**
   - **Atividade é monitorada em background (quando disponível)**
   - Submeter código
   - Ver resultados dos testes
   - Corrigir e reenviar se necessário (apenas antes do tempo acabar)
7. **Receber aviso quando tempo está próximo de acabar**
8. **Após expiração do tempo individual, não é possível mais submeter**
9. Ver resultados finais de todas as questões
10. **Em modo com pausa:**
    - Pode sair e voltar quantas vezes quiser (dentro do tempo total)
    - Progresso é mantido entre sessões
    - Código digitado é preservado

### Empresa revisando:
1. Visualizar submissões dos candidatos
2. **Filtrar por status do teste:**
   - Ver apenas testes concluídos
   - Ver testes em andamento
   - Ver testes já revisados pela IA
3. Abrir código submetido
4. **Visualizar relatório de monitoramento (quando disponível)**
   - Timeline de atividades durante o teste
   - Eventos de mudança de aba/janela
   - Tempo gasto em cada questão
   - Padrões de interação (cliques, digitação, etc)
   - Alertas de comportamento suspeito
5. Solicitar revisão automática por IA (quando disponível)
   - **Status muda para "ai_reviewed" após análise completa**
6. Revisar comentários e sugestões da IA
7. Adicionar comentários manuais em linhas específicas
8. Dar rating e feedback geral
9. Comparar diferentes candidatos
10. **Ver histórico de mudanças de status**

### Revisão Automática por IA (Futuro):
1. Empresa solicita revisão automática de uma submissão
2. Agente de IA analisa o código
3. Gera relatório com:
   - Análise de qualidade do código
   - Sugestões de melhoria
   - Pontos positivos e negativos
   - Comparação com boas práticas
   - Sugestão de rating automático
4. Empresa revisa e pode aceitar/rejeitar sugestões da IA
5. Comentários da IA podem ser editados ou complementados

## Objetivos de Negócio

- Facilitar processos de contratação técnica
- Reduzir tempo de avaliação de candidatos
- Padronizar avaliações técnicas
- Melhorar qualidade das contratações
- Fornecer métricas e insights sobre desempenho
