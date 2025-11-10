# 🚀 Default Data Project  

Este repositório serve como **template base** para iniciar projetos de dados em Python com boas práticas de organização, versionamento e automação.  

## 📦 Gerenciamento de dependências — Poetry  
[Poetry](https://python-poetry.org/) é utilizado para criar e gerenciar dependências do projeto.  

```bash
# Inicia um novo projeto
poetry init  

# Instala as dependências listadas no pyproject.toml
poetry install  

# Ativa o ambiente virtual
poetry shell  
```

## 🐍 Controle de versão do Python — Pyenv  
[Pyenv](https://github.com/pyenv/pyenv) permite fixar a versão do Python para garantir consistência.  

```bash
# Define a versão do Python local do projeto
pyenv local <versao escolhida> 
```

## 🌱 Versionamento do código — Git  
```bash
# Inicia o versionamento
git init  

# Fluxo básico
git add .  
git commit -m "inicialização do projeto"  
```

> 💡 Dica: configure um **.gitignore** para não versionar a venv, caches ou dados sensíveis.  

## 📚 Bibliotecas e ferramentas úteis  

- **[Mypy](https://mypy.readthedocs.io/)** → checagem de tipagem estática.  
- **[Ruff](https://docs.astral.sh/ruff/)** → linting rápido e eficiente.  
- **[Pydocstyle](https://www.pydocstyle.org/)** → garante boas práticas de docstrings.  
- **[Taskipy](https://taskipy.readthedocs.io/)** → facilita execução de tarefas via `pyproject.toml`.  
- **[MkDocs](https://www.mkdocs.org/)** → gera documentação estática do projeto.  
- **[GitHub Actions](https://docs.github.com/en/actions)** → CI/CD integrado ao GitHub.  

## ⚡ Sugestão de tasks (taskipy)  

Adicione no `pyproject.toml`:  

```toml
[tool.taskipy.tasks]
lint = "ruff check ."
typecheck = "mypy ."
docs = "mkdocs serve"
test = "pytest"
```

Agora é só rodar:  

```bash
task lint
task typecheck
task docs
task test
```

---

👉 Esse guia deve servir como **ponto de partida** para seus projetos de dados, garantindo padronização e velocidade na configuração.


## 📝 Convenção de Commits Semânticos  

A estrutura de um commit semântico segue o formato:  

```
<tipo>(<escopo>): <descrição>
```  

- **feat** → Nova funcionalidade  
  *Exemplo:* `feat(ingestao): Adiciona suporte para fonte de dados S3`  

- **fix** → Correção de bug  
  *Exemplo:* `fix(transformacao): Corrige erro de arredondamento em métrica X`  

- **docs** → Alterações na documentação  
  *Exemplo:* `docs(readme): Atualiza seção de pré-requisitos`  

- **style** → Mudanças de estilo (formatação, espaçamento, imports)  
  *Exemplo:* `style(code): Formata utils.py com black`  

- **refactor** → Refatoração de código sem alterar funcionalidades  
  *Exemplo:* `refactor(etl): Otimiza carregamento de dados em lote`  

- **test** → Adição ou correção de testes  
  *Exemplo:* `test(pipeline): Adiciona testes para validação de esquema`  

- **chore** → Tarefas de manutenção (dependências, configs)  
  *Exemplo:* `chore(deps): Atualiza versão do pandas para 2.0`  

- **build** → Alterações no sistema de build ou dependências externas  
  *Exemplo:* `build(docker): Otimiza imagem docker para produção`  

> 💡 **Benefícios:** commits claros ajudam na colaboração, rastreabilidade, geração de changelogs automáticos e versionamento semântico.  
