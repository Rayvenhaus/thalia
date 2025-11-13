# Thalia Interface Layout Concepts

## Desktop Interface Layout

### Main Layout Structure

The desktop interface is divided into several key zones that work together to create an immersive experience:

```
+-----------------------------------------------------------------------+
|                           SYSTEM BAR                                  |
+---------------+----------------------------+-------------------------+
|               |                            |                         |
|               |                            |                         |
|   CONTEXT     |        INTERACTION         |       SYSTEM            |
|   PANEL       |          ZONE              |       METRICS           |
|               |                            |                         |
|               |                            |                         |
|               |                            |                         |
|               |                            |                         |
|               |                            |                         |
|               |                            |                         |
+---------------+----------------------------+-------------------------+
|                         COMMAND TERMINAL                             |
+-----------------------------------------------------------------------+
```

#### 1. System Bar (Top)
- Height: 48px
- Contains: System status, session info, global controls
- Features: Time/date, system health indicators, settings access
- Behavior: Always visible, subtle ambient animations

#### 2. Context Panel (Left)
- Width: 25% of screen (collapsible)
- Contains: Conversation context, memory access, topic history
- Features: Neural network visualization of conversation flow
- Behavior: Expandable nodes, searchable history, context filters

#### 3. Interaction Zone (Center)
- Width: 50% of screen
- Contains: Primary conversation area, Thalia's responses, future 3D avatar
- Features: Dynamic conversation visualization, emotional indicators
- Behavior: Scrollable history, expandable message cards, voice visualization

#### 4. System Metrics (Right)
- Width: 25% of screen (collapsible)
- Contains: Memory system status, emotional state, thinking process
- Features: Real-time metrics, PAD emotional model visualization
- Behavior: Expandable panels, detailed tooltips, ambient animations

#### 5. Command Terminal (Bottom)
- Height: 64px (expandable)
- Contains: Text input, voice controls, command palette
- Features: Multi-modal input options, suggestion system
- Behavior: Expands during active input, collapses when inactive

### Alternative Layouts

#### Immersive Mode
```
+-----------------------------------------------------------------------+
|                                                                       |
|                                                                       |
|                                                                       |
|                                                                       |
|                         INTERACTION ZONE                              |
|                        (EXPANDED FULLSCREEN)                          |
|                                                                       |
|                                                                       |
|                                                                       |
|                                                                       |
+-----------------------------------------------------------------------+
|                         COMMAND TERMINAL                              |
+-----------------------------------------------------------------------+
```
- Hides context panel and system metrics
- Maximizes interaction zone for focused conversation
- Accessible via a toggle button or keyboard shortcut

#### Technical Mode
```
+---------------+----------------------------+--------------------------+
|               |                            |                          |
|   CONTEXT     |        INTERACTION         |       SYSTEM             |
|   PANEL       |          ZONE              |       METRICS            |
|   (EXPANDED)  |        (REDUCED)           |      (EXPANDED)          |
|               |                            |                          |
|               |                            |                          |
+---------------+----------------------------+--------------------------+
|                         COMMAND TERMINAL                              |
|                           (EXPANDED)                                  |
+-----------------------------------------------------------------------+
```
- Emphasizes technical details and system information
- Expanded terminal with command-line interface options
- More detailed metrics and memory visualization

#### Writing Assistant Mode
```
+-----------------------------------------------------------------------+
|                           SYSTEM BAR                                  |
+---------------+-------------------------------------------------------+
|               |                                                       |
|   CONTEXT     |                                                       |
|   PANEL       |                WRITING ZONE                           |
|   (NARROW)    |                                                       |
|               |                                                       |
|               |                                                       |
|               |                                                       |
+---------------+-------------------------------------------------------+
|                         COMMAND TERMINAL                              |
+-----------------------------------------------------------------------+
```
- Optimized for collaborative writing
- Expanded editor area with formatting tools
- Context panel shows relevant references and notes

## Mobile Interface Layout

The mobile interface transforms the desktop experience into a vertically stacked layout that preserves the core functionality:

### Default Mobile Layout

```
+-----------------------------------+
|             SYSTEM BAR            |
+-----------------------------------+
|                                   |
|                                   |
|          INTERACTION ZONE         |
|                                   |
|                                   |
|                                   |
+-----------------------------------+
|           COMMAND TERMINAL        |
+-----------------------------------+
```

- Swipeable panels for Context and System Metrics
- Expandable Command Terminal
- Collapsible System Bar

### Mobile Navigation System

The mobile interface uses a swipe-based navigation system:
- Swipe left: Reveals Context Panel
- Swipe right: Reveals System Metrics
- Swipe up: Expands Command Terminal
- Swipe down: Shows conversation history

### Mobile Panel States

#### Context Panel (Left Swipe)
```
+-----------------------------------+
|             SYSTEM BAR            |
+-----------------------------------+
|                                   |
|                                   |
|           CONTEXT PANEL           |
|                                   |
|                                   |
|                                   |
+-----------------------------------+
|           COMMAND TERMINAL        |
+-----------------------------------+
```

#### System Metrics (Right Swipe)
```
+-----------------------------------+
|             SYSTEM BAR            |
+-----------------------------------+
|                                   |
|                                   |
|          SYSTEM METRICS           |
|                                   |
|                                   |
|                                   |
+-----------------------------------+
|           COMMAND TERMINAL        |
+-----------------------------------+
```

#### Expanded Terminal (Swipe Up)
```
+-----------------------------------+
|             SYSTEM BAR            |
+-----------------------------------+
|                                   |
|         INTERACTION ZONE          |
|           (REDUCED)               |
|                                   |
+-----------------------------------+
|                                   |
|                                   |
|         COMMAND TERMINAL          |
|           (EXPANDED)              |
|                                   |
+-----------------------------------+
```

## Component Layout Details

### Neural Card Layout
```
+-----------------------------------+
|  HEADER BAR  |     INDICATORS     |
+-----------------------------------+
|                                   |
|             CONTENT               |
|                                   |
+-----------------------------------+
|   METADATA   |      ACTIONS       |
+-----------------------------------+
```
- Flexible content area that adapts to different types of information
- Consistent header and footer elements
- Expandable for additional details

### System Metrics Panel Layout
```
+-----------------------------------+
|           PANEL HEADER            |
+-----------------------------------+
|                                   |
|         EMOTIONAL STATE           |
|                                   |
+-----------------------------------+
|                                   |
|         MEMORY METRICS            |
|                                   |
+-----------------------------------+
|                                   |
|       PROCESSING ACTIVITY         |
|                                   |
+-----------------------------------+
|                                   |
|         SYSTEM HEALTH             |
|                                   |
+-----------------------------------+
```
- Collapsible sections
- Real-time updating metrics
- Interactive elements for deeper information

### Context Panel Layout
```
+-----------------------------------+
|           PANEL HEADER            |
+-----------------------------------+
|                                   |
|        CONVERSATION MAP           |
|                                   |
+-----------------------------------+
|                                   |
|         ACTIVE TOPICS             |
|                                   |
+-----------------------------------+
|                                   |
|        MEMORY REFERENCES          |
|                                   |
+-----------------------------------+
|                                   |
|         SEARCH/FILTER             |
|                                   |
+-----------------------------------+
```
- Neural network visualization of conversation
- Topic clustering and relationship mapping
- Searchable memory references

### Command Terminal Layout
```
+-----------------------------------+
|  MODE SELECTOR  |  INPUT OPTIONS  |
+-----------------------------------+
|                                   |
|           INPUT FIELD             |
|                                   |
+-----------------------------------+
|  SUGGESTIONS   |     ACTIONS      |
+-----------------------------------+
```
- Multiple input modes (text, voice, commands)
- Smart suggestions based on context
- Quick action buttons