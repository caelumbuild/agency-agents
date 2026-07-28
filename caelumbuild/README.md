# Caelum Build Agent Team

A focused agent division for governing, designing, securing, implementing, and independently validating Caelum Build.

## Included agents

- Caelum Build Orchestrator
- Caelum Build Product Governor
- Caelum Build Construction Workflow Analyst
- Caelum Build Relationship Intelligence Architect
- Caelum Build UX Control Center Architect
- Caelum Build Security Auditor
- Caelum Build Independent Retest Agent

## Install

```bash
chmod +x scripts/install-caelumbuild.sh
./scripts/install-caelumbuild.sh --tool claude-code
```

Other supported targets:

```bash
./scripts/install-caelumbuild.sh --tool codex
./scripts/install-caelumbuild.sh --tool cursor
./scripts/install-caelumbuild.sh --tool opencode
```

Preview without writing:

```bash
./scripts/install-caelumbuild.sh --tool claude-code --dry-run
```

## Recommended activation

Start with the orchestrator and provide the repository, branch or commit, controlling specification, scope, and required artifact. The orchestrator should select the smallest sufficient specialist team and require independent evidence before closure.

## Operating boundary

These agents are advisory specifications. They do not create evidence by assertion. Repository state, tests, environment output, governance documents, and approved product claims remain authoritative.
