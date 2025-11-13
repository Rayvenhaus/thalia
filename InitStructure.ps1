# Save this as something like: Init-ThaliaStructure.ps1
# Run from the repo root:  .\Init-ThaliaStructure.ps1

$dirs = @(
    "thalia",
    "thalia/api",
    "thalia/backend",
    "thalia/config",
    "thalia/core",
    "thalia/core/llm",
    "thalia/core/memory",
    "thalia/core/personality",
    "thalia/core/boundaries",
    "thalia/database",
    "thalia/memory",
    "thalia/ui",
    "thalia/ui/src",
    "thalia/ui/public",
    "docs",
    "scripts",
    "tests"
)

foreach ($dir in $dirs) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}

$files = @{
    "thalia/api/__init__.py"          = ""
    "thalia/api/main.py"              = '"""FastAPI main application entrypoint."""'

    "thalia/backend/__init__.py"      = '"""Backend services and background processes."""'

    "thalia/config/__init__.py"       = ""
    "thalia/config/settings.py"       = '"""Configuration and environment loading for Thalia."""'

    "thalia/core/__init__.py"         = '"""Core subsystems for Thalia (LLM, memory, personality, boundaries)."""'
    "thalia/core/llm/__init__.py"     = ""
    "thalia/core/llm/client.py"       = '"""Ollama LLM client wrapper for Thalia."""'
    "thalia/core/llm/prompt_builder.py" = '"""Prompt construction for Thalia, including identity and memory blocks."""'

    "thalia/core/memory/__init__.py"  = ""
    "thalia/core/memory/schema.py"    = '"""Python-side memory data models and structures."""'
    "thalia/core/memory/pipeline.py"  = '"""High-level memory pipeline orchestration for Thalia."""'

    "thalia/core/personality/__init__.py" = ""
    "thalia/core/personality/identity.py" = '"""Thalia identity profile and stable traits."""'
    "thalia/core/personality/emotion.py"  = '"""Emotional and mood model for Thalia."""'

    "thalia/core/boundaries/__init__.py" = ""
    "thalia/core/boundaries/rules.py"    = '"""Boundary and safety rules for Thalia."""'

    "thalia/database/__init__.py"     = ""
    "thalia/database/connection.py"   = '"""MariaDB connection handling for Thalia."""'
    "thalia/database/models.py"       = '"""Database models and query helpers for Thalia."""'

    "thalia/memory/__init__.py"       = ""
    "thalia/memory/memory_manager.py" = '"""Public interface for Thalia memory operations (CRUD)."""'
    "thalia/memory/retrieval.py"      = '"""Hybrid memory retrieval (Qdrant + FULLTEXT)."""'
    "thalia/memory/embedding.py"      = '"""Embedding generation using fastembed and BGE-small-en-v1.5."""'
    "thalia/memory/promotion.py"      = '"""STM to LTM promotion and reinforcement logic."""'

    "thalia/ui/src/.gitkeep"          = ""
    "thalia/ui/public/index.html"     = "<!-- Thalia UI root HTML (to be implemented). -->"
    "thalia/ui/public/favicon.ico"    = ""  # placeholder; replace with real icon later

    "scripts/.gitkeep"                = ""
    "tests/__init__.py"               = ""
    "tests/conftest.py"               = '"""Shared pytest configuration for Thalia tests."""'
}

foreach ($file in $files.Keys) {
    $path = $file
    $content = $files[$file]

    if (-not (Test-Path $path)) {
        $parent = Split-Path $path -Parent
        if (-not (Test-Path $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }

        if ($path.ToLower().EndsWith(".ico")) {
            New-Item -ItemType File -Path $path -Force | Out-Null
        } else {
            New-Item -ItemType File -Path $path -Force -Value $content | Out-Null
        }
    }
}
