# Thalia Project Brain (v1)

## 1. Purpose & Vision

Thalia is a **local AI companion** that runs entirely on Steven’s own hardware.  
She is designed to be:

- **Private** – everything runs locally; no cloud calls.
- **Persistent** – she remembers past sessions via a memory system (DB + vectors).
- **Conversational** – FastAPI backend, modern web UI frontend.
- **Human-like** in behaviour – she has an identity, emotions, and evolving memories.

Thalia is not a general chatbot. She is **one specific persona** running on Steven’s home lab.

---

## 2. Runtime Environment & Global Rules

- OS: Linux server (Thalia), fast machine with GPU (Aisling) on LAN.
- Backend: **Python + FastAPI**
- Frontend: **React/TypeScript**
- LLM: **Ollama** (currently Llama 3.1 70B) via local HTTP API.
- Vector DB: **Qdrant**
- Relational DB: **MariaDB**
- Embeddings: **BAAI/bge-small-en-v1.5 (384-dim)** via `fastembed`.
- Mode: **PRODUCTION ONLY** (no dev mode toggles).
- UI host: **192.168.1.83** (browser-facing UI must bind and resolve there).

**Secrets & config**

- Sensitive values live in `.env` / local config only.
- `.env` and any secrets MUST NOT be committed to Git or shown in code examples.
- Code must assume config comes from modules like `config/settings.py`, not hard-coded.

---

## 3. Canonical Directory Structure

```text
talia/
    api/
        main.py
        memory_api.py
    backend/
    config/
        settings.py
    core/
        llm/
            client.py
            prompt_builder.py
        memory/
            schema.py
            pipeline.py
        personality/
            identity.py
            emotion.py
        boundaries/
            rules.py
    database/
        connection.py
        models.py
    memory/
        memory_manager.py
        retrieval.py
        embedding.py
        promotion.py
    ui/
        src/
            components/
            pages/
            layout/
            hooks/
        public/
            index.html
            favicon.ico
    docs/
        THALIA_PROJECT_BRAIN.md
        MEMORY_SYSTEM.md
        API_REFERENCE.md
    scripts/
    tests/
```

If any existing code conflicts with this, the code must be migrated to match **this structure**.

---

## 4. Global Coding Conventions

- **Indentation**: 4 spaces
- **Functions**: camelCase (`getMemories`, `runQuery`)
- **Classes**: PascalCase (`MemoryManager`)
- **Constants**: UPPER_SNAKE_CASE
- **Type hints**: required on all Python functions
- **Logging**: use shared `logger` from `logging.py` (no stray prints)
- **No new libraries** unless explicitly requested

AI-generated code must:

1. Not invent new directories
2. Not rename existing public interfaces
3. Respect this file structure
4. Output only changed/new blocks when requested
5. Make small, atomic changes

---

## 5. Backend Architecture Overview

### FastAPI App (`api/main.py`)

- Mount all routers
- Add middleware (CORS, logging, error handling)
- Provide at least:
  - `GET /health`
  - `POST /chat`
  - `POST /memory/lookup`
  - `POST /memory/save`

### Chat Flow (high-level)

1. Receive `messages: List[{role, content}]`
2. Extract latest user message
3. Memory retrieval (hybrid: Qdrant + FULLTEXT)
4. Build LLM prompt (identity + boundaries + memory blocks)
5. Send to LLM via Ollama client
6. Return response + metadata
7. Pass interaction into memory pipeline (reinforcement/promotion)

---

## 6. Memory System Overview

- Memory tiers: Session → STM → LTM
- Storage: MariaDB for canonical records, Qdrant for vectors
- Embeddings: `fastembed` using BGE-small-en-v1.5 (384-dim)
- Retrieval combines vector + FULLTEXT + relationship intent filter
- Low-recall triggers `LOW_RECALL_REPLY` message
- `promotion.py` handles STM→LTM promotions

---

## 7. Identity, Emotion, Boundaries

### Identity

- Defined in `core/personality/identity.py`
- Read-only at runtime
- Contains backstory, stable facts, preferences

### Emotion

- In `core/personality/emotion.py`
- Represents mood using simple deterministic model
- Affects *phrasing*, not logic

### Boundaries

- In `core/boundaries/rules.py`
- Defines safety & behavioural constraints
- Enforced before LLM call and before UI output

---

## 8. Frontend (React/TS)

- Located at `ui/src/`
- UI calls FastAPI only (never directly hits Ollama/DB)
- Centralized API client (e.g. `api/client.ts`)
- Includes memory indicators, heartbeat, chat flow, dock/panels

---

## 9. Logging & Observability

- Use the shared logger
- Avoid logging sensitive content verbatim
- Catch and log exceptions internally, return safe errors to UI

---

## 10. Development & AI Collaboration Rules

When working with an AI (including ChatGPT):

1. Provide the relevant file(s)
2. Provide a **single, small, atomic task**
3. Include this Project Brain when needed
4. No subsystem rewrites in a single request
5. Architectural changes must be explained in English first

This document is **source of truth** for all future changes.

