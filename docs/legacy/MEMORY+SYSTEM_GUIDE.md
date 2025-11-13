# Thalia AI Companion - Memory System Guide

This guide provides detailed information about the memory system implementation for the Thalia AI Companion. The memory system is designed to provide a personalized experience by remembering important details from conversations.

## Table of Contents

1. [Memory System Architecture](#1-memory-system-architecture)
2. [Memory Tiers](#2-memory-tiers)
3. [Memory Promotion Rules](#3-memory-promotion-rules)
4. [Database Schema](#4-database-schema)
5. [Vector Database Integration](#5-vector-database-integration)
6. [Memory Manager Implementation](#6-memory-manager-implementation)
7. [API Endpoints](#7-api-endpoints)
8. [Integration with LLM](#8-integration-with-llm)
9. [Testing and Validation](#9-testing-and-validation)
10. [Optimization Tips](#10-optimization-tips)

## 1. Memory System Architecture

The memory system uses a three-tier architecture:

```
┌─────────────────┐      ┌─────────────────┐     ┌─────────────────┐
│  Session Memory │      │  Short-Term     │     │  Long-Term      │
│  (Ephemeral)    │ ──▶ │  Memory (STM)   │ ──▶ │  Memory (LTM)   │
└─────────────────┘      └─────────────────┘     └─────────────────┘
       │                       │                       │
       │                       │                       │
       ▼                       ▼                       ▼
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  MariaDB +      │     │  MariaDB +      │     │  MariaDB +      │
│  Qdrant Vector  │     │  Qdrant Vector  │     │  Qdrant Vector  │
│  Collection     │     │  Collection     │     │  Collection     │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

- **MariaDB**: Stores structured metadata about memories
- **Qdrant**: Stores vector embeddings for semantic search
- **Memory Manager**: Orchestrates operations across tiers

## 2. Memory Tiers

### 2.1 Session Memory

- **Purpose**: Store immediate conversation context
- **Lifetime**: Short (default: 24 hours)
- **Storage**: Both database and vector store
- **Content**: Raw conversation messages
- **Metadata**: Importance score, emotional values, tags

### 2.2 Short-Term Memory (STM)

- **Purpose**: Store important information from recent conversations
- **Lifetime**: Medium (default: 30 days)
- **Storage**: Both database and vector store
- **Content**: Summarized information with title
- **Metadata**: Importance score, emotional values, tags

### 2.3 Long-Term Memory (LTM)

- **Purpose**: Store critical information for long-term recall
- **Lifetime**: Indefinite (no automatic expiration)
- **Storage**: Both database and vector store
- **Content**: Detailed information with title, summary, and category
- **Metadata**: Importance score, emotional values, tags, user/Thalia votes

## 3. Memory Promotion Rules

### 3.1 Session → Short-Term Memory

Memories are auto-promoted if ANY of these are true:
- Importance score ≥ 0.8 (core memory)
- Has protected tags: preference, workflow, boundary, safety, identity
- Reinforced within session (same content appears ≥ 2 times)
- High emotional weight (≥ 7) with intimate level
- System agreements (lines starting with "we will", "remember that…", "from now on…")

### 3.2 Short-Term → Long-Term Memory

Memories are auto-promoted if ANY of these are true:
- Cross-session reinforcement (same content appears in ≥ 3 distinct sessions over ≥ 7 days)
- Core memory that has been reviewed and approved
- High emotional weight (≥ 8) with intimate level, referenced again in a later session

## 4. Database Schema

### 4.1 Core Tables

- **memory_metadata**: Central table with common fields for all memory tiers
- **session_memory**: Session-specific memory fields
- **short_term_memory**: STM-specific memory fields
- **long_term_memory**: LTM-specific memory fields
- **memory**: Unified memory table for easier querying

### 4.2 Supporting Tables

- **memory_relationships**: Links between related memories
- **memory_access_log**: Tracks memory access patterns
- **memory_promotion_log**: Records promotion events
- **conversations**: Stores conversation metadata
- **messages**: Stores individual messages

## 5. Vector Database Integration

### 5.1 Qdrant Collections

- **session_memory_collection**: Vectors for session memories
- **short_term_memory_collection**: Vectors for STM
- **long_term_memory_collection**: Vectors for LTM

### 5.2 Vector Operations

- **insert_vector**: Add new memory vectors
- **search_collection**: Find semantically similar memories
- **delete_vector**: Remove memory vectors
- **update_vector_payload**: Update metadata

### 5.3 Embedding Generation

- **Model**: all-MiniLM-L6-v2 (default)
- **Dimension**: 384
- **Fallback**: Simple hash-based embedding if model unavailable

## 6. Memory Manager Implementation

The `MemoryManager` class handles all memory operations:

### 6.1 Core Methods

- **create_session_memory**: Create new session memories
- **create_short_term_memory**: Create new STM entries
- **create_long_term_memory**: Create new LTM entries
- **get_memory_by_id**: Retrieve specific memories
- **search_memories**: Find relevant memories across tiers
- **promote_memory**: Move memories between tiers
- **get_promotion_candidates**: Find memories eligible for promotion

### 6.2 Utility Methods

- **delete_memory**: Remove memories
- **archive_memory**: Archive memories without deletion
- **unarchive_memory**: Restore archived memories
- **update_memory_tags**: Modify memory tags
- **update_memory_importance**: Change importance scores
- **update_memory_emotional_values**: Update emotional metadata
- **cleanup_expired_memories**: Remove expired memories

## 7. API Endpoints

### 7.1 Memory Creation

- `POST /memory/session`: Create session memory
- `POST /memory/short-term`: Create STM entry
- `POST /memory/long-term`: Create LTM entry

### 7.2 Memory Retrieval

- `GET /memory/{memory_id}`: Get specific memory
- `POST /memory/search`: Search memories by query

### 7.3 Memory Management

- `POST /memory/promote`: Promote memory between tiers
- `GET /memory/candidates/{from_tier}/{to_tier}`: Get promotion candidates
- `DELETE /memory/{memory_id}`: Delete memory
- `POST /memory/{memory_id}/archive`: Archive memory
- `POST /memory/{memory_id}/unarchive`: Unarchive memory
- `PUT /memory/{memory_id}/tags`: Update memory tags
- `PUT /memory/{memory_id}/importance`: Update importance score
- `PUT /memory/{memory_id}/emotional`: Update emotional values
- `POST /memory/cleanup`: Clean up expired memories

## 8. Integration with LLM

### 8.1 Memory Retrieval Flow

1. User sends message
2. System searches for relevant memories across tiers
3. Relevant memories are formatted and included in the prompt
4. LLM generates response using the enhanced prompt
5. Response is stored in session memory

### 8.2 Prompt Construction

```
[System Prompt]

You are Thalia, an AI companion with a British personality...

[Relevant Memories]

1. [LONG_TERM] User's name is Steven and he works as a software engineer.
2. [SHORT_TERM] User is planning a trip to Japan next month.
3. [SESSION] User mentioned feeling excited about learning Japanese.

[User Message]

I've been practicing some basic Japanese phrases for my trip.
```

### 8.3 Memory Creation Flow

1. User and Thalia exchange messages
2. Messages are stored in session memory
3. Important information is promoted to STM
4. Critical information is promoted to LTM
5. Memory system periodically cleans up expired memories

## 9. Testing and Validation

### 9.1 Basic Testing

```bash
# Test memory creation and retrieval
python scripts/test_memory.py

# Test integration with LLM
python scripts/test_integration.py --model thalia --interactive

# Test simplified local version
python scripts/test_thalia_local.py --model thalia
```

### 9.2 Advanced Testing

```bash
# Test memory promotion
python scripts/test_memory_promotion.py

# Test memory search
python scripts/test_memory_search.py

# Test memory lifecycle
python scripts/test_memory_lifecycle.py
```

## 10. Optimization Tips

### 10.1 Database Optimization

- **Indexing**: Ensure proper indexes on frequently queried fields
- **Connection Pooling**: Use connection pooling for better performance
- **Query Optimization**: Use EXPLAIN to analyze and optimize queries

### 10.2 Vector Search Optimization

- **Batch Operations**: Use batch operations for vector insertions
- **Filter Optimization**: Use efficient filters in vector searches
- **Vector Dimension**: Balance dimension size with performance

### 10.3 Memory Management

- **Promotion Thresholds**: Adjust promotion thresholds based on usage patterns
- **Expiration Policies**: Tune expiration times for different memory tiers
- **Batch Processing**: Process memory operations in batches when possible

### 10.4 Integration Optimization

- **Prompt Engineering**: Optimize how memories are formatted in prompts
- **Memory Relevance**: Tune relevance thresholds for memory inclusion
- **Context Window Management**: Balance memory inclusion with context window limits

## Implementation Checklist

- [x] Database models
- [x] Vector database integration
- [x] Memory manager implementation
- [x] API endpoints
- [x] Basic testing
- [ ] Advanced testing
- [ ] Performance optimization
- [ ] Integration with web interface
- [ ] Mobile app integration
- [ ] Voice capabilities

By following this guide, you'll have a comprehensive understanding of the memory system architecture and implementation details for the Thalia AI Companion.