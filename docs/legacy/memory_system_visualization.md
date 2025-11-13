# Memory System Visualization Component

## Overview

The Memory System Visualization component provides an immersive, interactive representation of Thalia's three-tier memory architecture (session, short-term, and long-term memory). This visualization allows users to understand how Thalia processes, stores, and retrieves information, creating a more transparent and engaging AI companion experience.

## Memory Model Representation

### Three-Tier Architecture

The visualization represents Thalia's memory system as three interconnected layers:

1. **Session Memory**
   - Represents the current conversation context
   - Highly accessible but temporary storage
   - Visualized as an inner ring/layer with active, bright nodes

2. **Short-Term Memory**
   - Represents information retained across multiple sessions
   - Medium-term storage with moderate accessibility
   - Visualized as a middle ring/layer with semi-bright nodes

3. **Long-Term Memory**
   - Represents core knowledge and important memories
   - Permanent storage with structured retrieval
   - Visualized as an outer ring/layer with stable, subdued nodes

### Memory Processes Visualization

The component visualizes key memory processes:

1. **Memory Formation**
   - New information entering the system
   - Animated as particles/nodes forming in the session memory layer

2. **Memory Promotion**
   - Important memories moving between tiers
   - Animated as nodes transitioning between layers

3. **Memory Retrieval**
   - Accessing stored information
   - Animated as activation paths lighting up across the memory network

4. **Memory Association**
   - Connections between related memories
   - Visualized as links between memory nodes

## Visual Design

### Core Concept: Memory Space

The memory system is visualized as a dynamic, multi-layered network:

- **Memory Nodes**: Individual memory units
- **Memory Clusters**: Groups of related memories
- **Connection Paths**: Relationships between memories
- **Activation Patterns**: Visual representation of memory access

### Visual Elements

#### Memory Nodes
- **Session Memory Nodes**: Bright, pulsing nodes in Neural Blue (`#00A6FF`)
- **Short-Term Memory Nodes**: Medium brightness nodes in Cyber Teal (`#00FFD1`)
- **Long-Term Memory Nodes**: Stable nodes in Digital Magenta (`#FF00A6`)
- **Node Size**: Varies based on memory importance or recency
- **Node Glow**: Intensity reflects access frequency

#### Memory Connections
- **Direct Connections**: Solid lines between directly related memories
- **Associative Connections**: Dashed lines between indirectly related memories
- **Connection Strength**: Line thickness represents relationship strength
- **Connection Animation**: Pulses of light traveling along connections during retrieval

#### Memory Layers
- **Session Layer**: Inner ring/sphere with dynamic, rapidly changing nodes
- **Short-Term Layer**: Middle ring/sphere with semi-stable nodes
- **Long-Term Layer**: Outer ring/sphere with stable, organized nodes
- **Layer Boundaries**: Subtle gradient transitions between memory tiers

#### Memory Processes
- **Formation Animation**: Particles coalescing into new memory nodes
- **Promotion Animation**: Nodes transitioning between layers with trail effects
- **Retrieval Animation**: Activation waves spreading from query to relevant memories
- **Forgetting Animation**: Nodes gradually fading out when memories expire

### Layout Options

#### Concentric Rings (2D Default View)
```
                  Long-Term Memory
              /                      \
            /                          \
          /       Short-Term Memory      \
         |       /                \       |
         |      /                  \      |
         |     |   Session Memory   |     |
         |     |                    |     |
         |      \                  /      |
          \       \                /       /
            \                          /
              \                      /
                  Memory System
```

#### Spherical Layers (3D Enhanced View)
```
                  .-'-.
              .-'       '-.
          .-'               '-.
        .'                     '.
       /                         \
      |     .-'-.                 |
      |  .-'     '-.              |
      | /           \             |
      ||      O      |            |
      | \           /             |
      |  '-._     _.-'            |
      |      '-.-'                |
       \                         /
        '.                     .'
          '-._             _.-'
              '-._     _.-'
                  '-.-'
```

#### Neural Network View (Alternative View)
```
       O       O       O
      /|\     /|\     /|\
     O O O   O O O   O O O
    /|\ /|\ /|\ /|\ /|\ /|\
   O O O O O O O O O O O O O
```

## Interaction Design

### Navigation Controls
- **Pan**: Click and drag to move around the memory space
- **Zoom**: Scroll to zoom in/out of memory layers
- **Rotate**: (In 3D view) Right-click and drag to rotate the view
- **Reset**: Button to return to default view

### Memory Exploration
- **Hover**: Shows memory preview and metadata
- **Click**: Selects a memory, showing full content and connections
- **Double-click**: Focuses on a memory cluster
- **Search**: Highlights memories matching search terms

### Filter Controls
- **Layer Filters**: Toggle visibility of memory layers
- **Time Filters**: Filter memories by creation/access time
- **Importance Filters**: Filter memories by importance score
- **Topic Filters**: Filter memories by associated topics

### Memory Operations
- **Pin**: Keep important memories visible
- **Trace**: Visualize the history/lineage of a memory
- **Compare**: Select multiple memories to compare relationships
- **Expand**: Show all connections for a selected memory

## Technical Implementation

### Component Structure

```typescript
interface MemorySystemVisualizationProps {
  // Memory data
  sessionMemories: Memory[];
  shortTermMemories: Memory[];
  longTermMemories: Memory[];
  
  // Memory connections
  connections: MemoryConnection[];
  
  // Active processes
  activeProcesses: MemoryProcess[];
  
  // View options
  viewMode: '2d' | '3d' | 'network';
  showLabels: boolean;
  focusedMemoryId?: string;
  
  // Interaction handlers
  onMemorySelect: (memoryId: string) => void;
  onMemoryHover: (memoryId: string | null) => void;
  onViewChange: (viewMode: '2d' | '3d' | 'network') => void;
}

interface Memory {
  id: string;
  content: string;
  type: 'session' | 'short_term' | 'long_term';
  importance: number;
  created: string;
  lastAccessed: string;
  accessCount: number;
  topics: string[];
  metadata: Record<string, any>;
}

interface MemoryConnection {
  sourceId: string;
  targetId: string;
  strength: number;
  type: 'direct' | 'associative';
}

interface MemoryProcess {
  type: 'formation' | 'promotion' | 'retrieval' | 'forgetting';
  memoryId: string;
  sourceType?: 'session' | 'short_term' | 'long_term';
  targetType?: 'session' | 'short_term' | 'long_term';
  progress: number; // 0 to 1
  startTime: number;
}

const MemorySystemVisualization: React.FC<MemorySystemVisualizationProps> = ({
  sessionMemories,
  shortTermMemories,
  longTermMemories,
  connections,
  activeProcesses,
  viewMode,
  showLabels,
  focusedMemoryId,
  onMemorySelect,
  onMemoryHover,
  onViewChange
}) => {
  // Component implementation
};
```

### 2D Concentric Rings Implementation

The 2D view uses SVG for rendering the memory system:

```typescript
const ConcentricRingsView: React.FC<{
  sessionMemories: Memory[];
  shortTermMemories: Memory[];
  longTermMemories: Memory[];
  connections: MemoryConnection[];
  activeProcesses: MemoryProcess[];
  width: number;
  height: number;
  onMemorySelect: (memoryId: string) => void;
  onMemoryHover: (memoryId: string | null) => void;
}> = ({
  sessionMemories,
  shortTermMemories,
  longTermMemories,
  connections,
  activeProcesses,
  width,
  height,
  onMemorySelect,
  onMemoryHover
}) => {
  // Calculate layout
  const centerX = width / 2;
  const centerY = height / 2;
  
  const sessionRadius = Math.min(width, height) * 0.15;
  const shortTermRadius = Math.min(width, height) * 0.3;
  const longTermRadius = Math.min(width, height) * 0.45;
  
  // Position memories in concentric rings
  const positionedSessionMemories = positionMemoriesInRing(
    sessionMemories,
    centerX,
    centerY,
    sessionRadius
  );
  
  const positionedShortTermMemories = positionMemoriesInRing(
    shortTermMemories,
    centerX,
    centerY,
    shortTermRadius
  );
  
  const positionedLongTermMemories = positionMemoriesInRing(
    longTermMemories,
    centerX,
    centerY,
    longTermRadius
  );
  
  // All positioned memories
  const allMemories = [
    ...positionedSessionMemories,
    ...positionedShortTermMemories,
    ...positionedLongTermMemories
  ];
  
  // Memory map for quick lookup
  const memoryMap = allMemories.reduce((map, memory) => {
    map[memory.id] = memory;
    return map;
  }, {} as Record<string, PositionedMemory>);
  
  // Render connections
  const connectionElements = connections.map(connection => {
    const source = memoryMap[connection.sourceId];
    const target = memoryMap[connection.targetId];
    
    if (!source || !target) return null;
    
    return (
      <MemoryConnection
        key={`${connection.sourceId}-${connection.targetId}`}
        source={source}
        target={target}
        strength={connection.strength}
        type={connection.type}
      />
    );
  });
  
  // Render memory layers
  return (
    <svg width={width} height={height}>
      {/* Background rings */}
      <circle
        cx={centerX}
        cy={centerY}
        r={longTermRadius}
        fill="none"
        stroke="var(--digital-magenta)"
        strokeWidth="1"
        strokeOpacity="0.2"
      />
      <circle
        cx={centerX}
        cy={centerY}
        r={shortTermRadius}
        fill="none"
        stroke="var(--cyber-teal)"
        strokeWidth="1"
        strokeOpacity="0.2"
      />
      <circle
        cx={centerX}
        cy={centerY}
        r={sessionRadius}
        fill="none"
        stroke="var(--neural-blue)"
        strokeWidth="1"
        strokeOpacity="0.2"
      />
      
      {/* Connections */}
      <g className="connections-layer">
        {connectionElements}
      </g>
      
      {/* Memory nodes */}
      <g className="long-term-memories">
        {positionedLongTermMemories.map(memory => (
          <MemoryNode
            key={memory.id}
            memory={memory}
            onSelect={onMemorySelect}
            onHover={onMemoryHover}
          />
        ))}
      </g>
      <g className="short-term-memories">
        {positionedShortTermMemories.map(memory => (
          <MemoryNode
            key={memory.id}
            memory={memory}
            onSelect={onMemorySelect}
            onHover={onMemoryHover}
          />
        ))}
      </g>
      <g className="session-memories">
        {positionedSessionMemories.map(memory => (
          <MemoryNode
            key={memory.id}
            memory={memory}
            onSelect={onMemorySelect}
            onHover={onMemoryHover}
          />
        ))}
      </g>
      
      {/* Active processes */}
      <g className="memory-processes">
        {activeProcesses.map(process => (
          <MemoryProcess
            key={`${process.type}-${process.memoryId}`}
            process={process}
            memoryMap={memoryMap}
            centerX={centerX}
            centerY={centerY}
          />
        ))}
      </g>
    </svg>
  );
};

// Helper function to position memories in a ring
const positionMemoriesInRing = (
  memories: Memory[],
  centerX: number,
  centerY: number,
  radius: number
): PositionedMemory[] => {
  return memories.map((memory, index) => {
    const angle = (index / memories.length) * Math.PI * 2;
    const x = centerX + Math.cos(angle) * radius;
    const y = centerY + Math.sin(angle) * radius;
    
    return {
      ...memory,
      x,
      y,
      radius: 5 + memory.importance * 5
    };
  });
};
```

### 3D Spherical Implementation

The 3D view uses Three.js for rendering:

```typescript
const SphericalView: React.FC<{
  sessionMemories: Memory[];
  shortTermMemories: Memory[];
  longTermMemories: Memory[];
  connections: MemoryConnection[];
  activeProcesses: MemoryProcess[];
  width: number;
  height: number;
  onMemorySelect: (memoryId: string) => void;
  onMemoryHover: (memoryId: string | null) => void;
}> = ({
  sessionMemories,
  shortTermMemories,
  longTermMemories,
  connections,
  activeProcesses,
  width,
  height,
  onMemorySelect,
  onMemoryHover
}) => {
  const mountRef = useRef<HTMLDivElement>(null);
  const [scene, setScene] = useState<THREE.Scene | null>(null);
  const [camera, setCamera] = useState<THREE.PerspectiveCamera | null>(null);
  const [renderer, setRenderer] = useState<THREE.WebGLRenderer | null>(null);
  const [controls, setControls] = useState<OrbitControls | null>(null);
  
  // Initialize Three.js scene
  useEffect(() => {
    if (!mountRef.current) return;
    
    // Create scene
    const newScene = new THREE.Scene();
    newScene.background = new THREE.Color(0x0A0E17);
    
    // Create camera
    const newCamera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000);
    newCamera.position.z = 5;
    
    // Create renderer
    const newRenderer = new THREE.WebGLRenderer({ antialias: true });
    newRenderer.setSize(width, height);
    newRenderer.setPixelRatio(window.devicePixelRatio);
    mountRef.current.appendChild(newRenderer.domElement);
    
    // Create controls
    const newControls = new OrbitControls(newCamera, newRenderer.domElement);
    newControls.enableDamping = true;
    newControls.dampingFactor = 0.05;
    
    // Add ambient light
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
    newScene.add(ambientLight);
    
    // Add directional light
    const directionalLight = new THREE.DirectionalLight(0xffffff, 0.8);
    directionalLight.position.set(0, 10, 10);
    newScene.add(directionalLight);
    
    // Create layer spheres
    const sessionSphere = createLayerSphere(0.5, 0x00A6FF, 0.1);
    const shortTermSphere = createLayerSphere(1.0, 0x00FFD1, 0.05);
    const longTermSphere = createLayerSphere(1.5, 0xFF00A6, 0.03);
    
    newScene.add(sessionSphere);
    newScene.add(shortTermSphere);
    newScene.add(longTermSphere);
    
    // Set state
    setScene(newScene);
    setCamera(newCamera);
    setRenderer(newRenderer);
    setControls(newControls);
    
    // Animation loop
    const animate = () => {
      requestAnimationFrame(animate);
      
      if (newControls) {
        newControls.update();
      }
      
      newRenderer.render(newScene, newCamera);
    };
    
    animate();
    
    // Cleanup
    return () => {
      if (mountRef.current) {
        mountRef.current.removeChild(newRenderer.domElement);
      }
    };
  }, [width, height]);
  
  // Update memory nodes
  useEffect(() => {
    if (!scene) return;
    
    // Remove existing memory nodes
    const existingNodes = scene.children.filter(
      child => child.userData.type === 'memory'
    );
    existingNodes.forEach(node => scene.remove(node));
    
    // Add session memory nodes
    const sessionNodes = createMemoryNodes(
      sessionMemories,
      0.5,
      0x00A6FF
    );
    sessionNodes.forEach(node => scene.add(node));
    
    // Add short-term memory nodes
    const shortTermNodes = createMemoryNodes(
      shortTermMemories,
      1.0,
      0x00FFD1
    );
    shortTermNodes.forEach(node => scene.add(node));
    
    // Add long-term memory nodes
    const longTermNodes = createMemoryNodes(
      longTermMemories,
      1.5,
      0xFF00A6
    );
    longTermNodes.forEach(node => scene.add(node));
    
  }, [scene, sessionMemories, shortTermMemories, longTermMemories]);
  
  // Update connections
  useEffect(() => {
    if (!scene) return;
    
    // Remove existing connections
    const existingConnections = scene.children.filter(
      child => child.userData.type === 'connection'
    );
    existingConnections.forEach(connection => scene.remove(connection));
    
    // Create memory map
    const memoryMap = new Map();
    scene.children.forEach(child => {
      if (child.userData.type === 'memory') {
        memoryMap.set(child.userData.id, child);
      }
    });
    
    // Add connections
    connections.forEach(connection => {
      const sourceNode = memoryMap.get(connection.sourceId);
      const targetNode = memoryMap.get(connection.targetId);
      
      if (sourceNode && targetNode) {
        const connectionLine = createConnectionLine(
          sourceNode.position,
          targetNode.position,
          connection.strength,
          connection.type === 'direct' ? 0xffffff : 0xaaaaaa
        );
        connectionLine.userData = {
          type: 'connection',
          sourceId: connection.sourceId,
          targetId: connection.targetId
        };
        scene.add(connectionLine);
      }
    });
    
  }, [scene, connections]);
  
  // Handle window resize
  useEffect(() => {
    if (!camera || !renderer) return;
    
    camera.aspect = width / height;
    camera.updateProjectionMatrix();
    renderer.setSize(width, height);
    
  }, [camera, renderer, width, height]);
  
  return <div ref={mountRef} style={{ width, height }} />;
};

// Helper function to create a layer sphere
const createLayerSphere = (
  radius: number,
  color: number,
  opacity: number
): THREE.Mesh => {
  const geometry = new THREE.SphereGeometry(radius, 32, 32);
  const material = new THREE.MeshBasicMaterial({
    color,
    transparent: true,
    opacity,
    wireframe: true
  });
  const sphere = new THREE.Mesh(geometry, material);
  return sphere;
};

// Helper function to create memory nodes
const createMemoryNodes = (
  memories: Memory[],
  radius: number,
  color: number
): THREE.Mesh[] => {
  return memories.map(memory => {
    // Position on sphere
    const phi = Math.acos(-1 + (2 * Math.random()));
    const theta = 2 * Math.PI * Math.random();
    
    const x = radius * Math.sin(phi) * Math.cos(theta);
    const y = radius * Math.sin(phi) * Math.sin(theta);
    const z = radius * Math.cos(phi);
    
    // Create node
    const nodeSize = 0.03 + (memory.importance * 0.05);
    const geometry = new THREE.SphereGeometry(nodeSize, 16, 16);
    const material = new THREE.MeshPhongMaterial({
      color,
      emissive: color,
      emissiveIntensity: 0.5,
      transparent: true,
      opacity: 0.8
    });
    
    const node = new THREE.Mesh(geometry, material);
    node.position.set(x, y, z);
    node.userData = {
      type: 'memory',
      id: memory.id,
      data: memory
    };
    
    return node;
  });
};

// Helper function to create connection line
const createConnectionLine = (
  start: THREE.Vector3,
  end: THREE.Vector3,
  strength: number,
  color: number
): THREE.Line => {
  const points = [start, end];
  const geometry = new THREE.BufferGeometry().setFromPoints(points);
  const material = new THREE.LineBasicMaterial({
    color,
    transparent: true,
    opacity: 0.2 + (strength * 0.6),
    linewidth: 1
  });
  
  return new THREE.Line(geometry, material);
};
```

### Memory Node Component

Each memory is represented by a customized node component:

```typescript
interface MemoryNodeProps {
  memory: PositionedMemory;
  onSelect: (memoryId: string) => void;
  onHover: (memoryId: string | null) => void;
  isActive?: boolean;
}

interface PositionedMemory extends Memory {
  x: number;
  y: number;
  radius: number;
}

const MemoryNode: React.FC<MemoryNodeProps> = ({
  memory,
  onSelect,
  onHover,
  isActive = false
}) => {
  const nodeColor = getMemoryTypeColor(memory.type);
  const glowIntensity = calculateGlowIntensity(memory);
  const nodeSize = memory.radius;
  
  return (
    <g
      className={`memory-node ${memory.type} ${isActive ? 'active' : ''}`}
      onClick={() => onSelect(memory.id)}
      onMouseEnter={() => onHover(memory.id)}
      onMouseLeave={() => onHover(null)}
    >
      {/* Glow effect */}
      <circle
        cx={memory.x}
        cy={memory.y}
        r={nodeSize * 2}
        fill={nodeColor}
        opacity={0.1 * glowIntensity}
        filter="blur(5px)"
      />
      
      {/* Main node */}
      <circle
        cx={memory.x}
        cy={memory.y}
        r={nodeSize}
        fill={nodeColor}
        opacity={0.7}
        stroke={isActive ? 'white' : nodeColor}
        strokeWidth={isActive ? 2 : 1}
      />
      
      {/* Pulse animation for active nodes */}
      {isActive && (
        <circle
          cx={memory.x}
          cy={memory.y}
          r={nodeSize * 1.5}
          fill="none"
          stroke={nodeColor}
          strokeWidth="1"
          opacity="0.5"
          className="pulse-animation"
        />
      )}
    </g>
  );
};

// Helper function to get color based on memory type
const getMemoryTypeColor = (type: 'session' | 'short_term' | 'long_term'): string => {
  switch (type) {
    case 'session':
      return 'var(--neural-blue)';
    case 'short_term':
      return 'var(--cyber-teal)';
    case 'long_term':
      return 'var(--digital-magenta)';
  }
};

// Helper function to calculate glow intensity
const calculateGlowIntensity = (memory: Memory): number => {
  // Base intensity from importance
  let intensity = memory.importance * 0.5;
  
  // Add recency factor
  const lastAccessedTime = new Date(memory.lastAccessed).getTime();
  const now = Date.now();
  const hoursSinceAccess = (now - lastAccessedTime) / (1000 * 60 * 60);
  const recencyFactor = Math.max(0, 1 - (hoursSinceAccess / 24)); // Decay over 24 hours
  
  intensity += recencyFactor * 0.3;
  
  // Add access count factor
  const accessFactor = Math.min(1, memory.accessCount / 10); // Max out at 10 accesses
  intensity += accessFactor * 0.2;
  
  return Math.min(1, intensity);
};
```

### Memory Connection Component

Connections between memories are visualized as lines with appropriate styling:

```typescript
interface MemoryConnectionProps {
  source: PositionedMemory;
  target: PositionedMemory;
  strength: number;
  type: 'direct' | 'associative';
}

const MemoryConnection: React.FC<MemoryConnectionProps> = ({
  source,
  target,
  strength,
  type
}) => {
  // Calculate control point for curved line
  const midX = (source.x + target.x) / 2;
  const midY = (source.y + target.y) / 2;
  
  // Add some curvature
  const dx = target.x - source.x;
  const dy = target.y - source.y;
  const dist = Math.sqrt(dx * dx + dy * dy);
  
  // Perpendicular offset for control point
  const offsetX = -dy * 0.2;
  const offsetY = dx * 0.2;
  
  const controlX = midX + offsetX;
  const controlY = midY + offsetY;
  
  // Path for the connection
  const path = `M ${source.x} ${source.y} Q ${controlX} ${controlY} ${target.x} ${target.y}`;
  
  // Style based on connection type and strength
  const strokeWidth = 1 + strength * 2;
  const strokeDasharray = type === 'direct' ? 'none' : '3,3';
  const opacity = 0.2 + strength * 0.6;
  
  // Color based on memory types
  const sourceColor = getMemoryTypeColor(source.type);
  const targetColor = getMemoryTypeColor(target.type);
  
  // Create gradient ID
  const gradientId = `connection-${source.id}-${target.id}`;
  
  return (
    <>
      {/* Define gradient */}
      <defs>
        <linearGradient id={gradientId} x1="0%" y1="0%" x2="100%" y2="0%">
          <stop offset="0%" stopColor={sourceColor} />
          <stop offset="100%" stopColor={targetColor} />
        </linearGradient>
      </defs>
      
      {/* Connection line */}
      <path
        d={path}
        stroke={`url(#${gradientId})`}
        strokeWidth={strokeWidth}
        strokeDasharray={strokeDasharray}
        fill="none"
        opacity={opacity}
      />
      
      {/* Animated pulse along the connection (for active connections) */}
      {strength > 0.7 && (
        <circle
          r="3"
          fill="white"
          opacity="0.8"
          className="connection-pulse"
        >
          <animateMotion
            dur="1.5s"
            repeatCount="indefinite"
            path={path}
          />
        </circle>
      )}
    </>
  );
};
```

### Memory Process Visualization

Active memory processes are visualized with animations:

```typescript
interface MemoryProcessProps {
  process: MemoryProcess;
  memoryMap: Record<string, PositionedMemory>;
  centerX: number;
  centerY: number;
}

const MemoryProcess: React.FC<MemoryProcessProps> = ({
  process,
  memoryMap,
  centerX,
  centerY
}) => {
  const memory = memoryMap[process.memoryId];
  if (!memory) return null;
  
  switch (process.type) {
    case 'formation':
      return (
        <FormationProcess
          memory={memory}
          progress={process.progress}
          centerX={centerX}
          centerY={centerY}
        />
      );
    case 'promotion':
      return (
        <PromotionProcess
          memory={memory}
          sourceType={process.sourceType!}
          targetType={process.targetType!}
          progress={process.progress}
          centerX={centerX}
          centerY={centerY}
        />
      );
    case 'retrieval':
      return (
        <RetrievalProcess
          memory={memory}
          progress={process.progress}
        />
      );
    case 'forgetting':
      return (
        <ForgettingProcess
          memory={memory}
          progress={process.progress}
        />
      );
    default:
      return null;
  }
};

// Formation process animation
const FormationProcess: React.FC<{
  memory: PositionedMemory;
  progress: number;
  centerX: number;
  centerY: number;
}> = ({ memory, progress, centerX, centerY }) => {
  // Calculate intermediate position
  const x = centerX + (memory.x - centerX) * progress;
  const y = centerY + (memory.y - centerY) * progress;
  const radius = memory.radius * progress;
  
  return (
    <g className="formation-process">
      <circle
        cx={x}
        cy={y}
        r={radius}
        fill={getMemoryTypeColor(memory.type)}
        opacity={0.7 * progress}
      />
      <circle
        cx={x}
        cy={y}
        r={radius * 1.5}
        fill="none"
        stroke={getMemoryTypeColor(memory.type)}
        strokeWidth="1"
        opacity={0.3 * progress}
      />
    </g>
  );
};

// Promotion process animation
const PromotionProcess: React.FC<{
  memory: PositionedMemory;
  sourceType: 'session' | 'short_term' | 'long_term';
  targetType: 'session' | 'short_term' | 'long_term';
  progress: number;
  centerX: number;
  centerY: number;
}> = ({ memory, sourceType, targetType, progress, centerX, centerY }) => {
  // Calculate source and target radii
  const sourceRadius = getRadiusForType(sourceType);
  const targetRadius = getRadiusForType(targetType);
  
  // Calculate source and target positions
  const sourceAngle = Math.atan2(memory.y - centerY, memory.x - centerX);
  const sourceX = centerX + Math.cos(sourceAngle) * sourceRadius;
  const sourceY = centerY + Math.sin(sourceAngle) * sourceRadius;
  
  const targetX = centerX + Math.cos(sourceAngle) * targetRadius;
  const targetY = centerY + Math.sin(sourceAngle) * targetRadius;
  
  // Calculate current position
  const x = sourceX + (targetX - sourceX) * progress;
  const y = sourceY + (targetY - sourceY) * progress;
  
  // Colors
  const sourceColor = getMemoryTypeColor(sourceType);
  const targetColor = getMemoryTypeColor(targetType);
  
  return (
    <g className="promotion-process">
      {/* Trail effect */}
      <path
        d={`M ${sourceX} ${sourceY} L ${x} ${y}`}
        stroke={sourceColor}
        strokeWidth="2"
        opacity="0.5"
      />
      
      {/* Moving node */}
      <circle
        cx={x}
        cy={y}
        r={memory.radius}
        fill={progress < 0.5 ? sourceColor : targetColor}
        opacity="0.8"
      />
      
      {/* Glow effect */}
      <circle
        cx={x}
        cy={y}
        r={memory.radius * 2}
        fill={progress < 0.5 ? sourceColor : targetColor}
        opacity="0.2"
        filter="blur(3px)"
      />
    </g>
  );
};

// Retrieval process animation
const RetrievalProcess: React.FC<{
  memory: PositionedMemory;
  progress: number;
}> = ({ memory, progress }) => {
  const pulseRadius = memory.radius * (1 + progress * 3);
  const opacity = 0.8 * (1 - progress);
  
  return (
    <g className="retrieval-process">
      <circle
        cx={memory.x}
        cy={memory.y}
        r={pulseRadius}
        fill="none"
        stroke={getMemoryTypeColor(memory.type)}
        strokeWidth="2"
        opacity={opacity}
      />
      <circle
        cx={memory.x}
        cy={memory.y}
        r={memory.radius}
        fill={getMemoryTypeColor(memory.type)}
        opacity="1"
      />
    </g>
  );
};

// Forgetting process animation
const ForgettingProcess: React.FC<{
  memory: PositionedMemory;
  progress: number;
}> = ({ memory, progress }) => {
  const opacity = 0.8 * (1 - progress);
  const radius = memory.radius * (1 - progress * 0.5);
  
  return (
    <g className="forgetting-process">
      <circle
        cx={memory.x}
        cy={memory.y}
        r={radius}
        fill={getMemoryTypeColor(memory.type)}
        opacity={opacity}
      />
      <circle
        cx={memory.x}
        cy={memory.y}
        r={memory.radius * 1.5}
        fill="none"
        stroke={getMemoryTypeColor(memory.type)}
        strokeWidth="1"
        strokeDasharray="2,2"
        opacity={opacity * 0.5}
      />
    </g>
  );
};

// Helper function to get radius for memory type
const getRadiusForType = (type: 'session' | 'short_term' | 'long_term'): number => {
  switch (type) {
    case 'session':
      return 100;
    case 'short_term':
      return 200;
    case 'long_term':
      return 300;
  }
};
```

## Memory Details Panel

When a memory is selected, a details panel shows its content and metadata:

```typescript
interface MemoryDetailsPanelProps {
  memory: Memory | null;
  onClose: () => void;
  onPromote?: (memoryId: string) => void;
  onDelete?: (memoryId: string) => void;
}

const MemoryDetailsPanel: React.FC<MemoryDetailsPanelProps> = ({
  memory,
  onClose,
  onPromote,
  onDelete
}) => {
  if (!memory) return null;
  
  return (
    <DetailsPanelContainer>
      <DetailsPanelHeader>
        <MemoryTypeIndicator type={memory.type} />
        <DetailsPanelTitle>Memory Details</DetailsPanelTitle>
        <CloseButton onClick={onClose}>×</CloseButton>
      </DetailsPanelHeader>
      
      <DetailsPanelContent>
        <MemoryContent>{memory.content}</MemoryContent>
        
        <MetadataSection>
          <MetadataItem>
            <MetadataLabel>Created:</MetadataLabel>
            <MetadataValue>{formatDate(memory.created)}</MetadataValue>
          </MetadataItem>
          <MetadataItem>
            <MetadataLabel>Last Accessed:</MetadataLabel>
            <MetadataValue>{formatDate(memory.lastAccessed)}</MetadataValue>
          </MetadataItem>
          <MetadataItem>
            <MetadataLabel>Access Count:</MetadataLabel>
            <MetadataValue>{memory.accessCount}</MetadataValue>
          </MetadataItem>
          <MetadataItem>
            <MetadataLabel>Importance:</MetadataLabel>
            <MetadataValue>
              <ImportanceBar value={memory.importance} />
            </MetadataValue>
          </MetadataItem>
        </MetadataSection>
        
        <TopicsSection>
          <SectionTitle>Topics</SectionTitle>
          <TopicsList>
            {memory.topics.map(topic => (
              <TopicTag key={topic}>{topic}</TopicTag>
            ))}
          </TopicsList>
        </TopicsSection>
        
        <ActionsSection>
          {memory.type !== 'long_term' && onPromote && (
            <ActionButton onClick={() => onPromote(memory.id)}>
              Promote Memory
            </ActionButton>
          )}
          {onDelete && (
            <ActionButton danger onClick={() => onDelete(memory.id)}>
              Delete Memory
            </ActionButton>
          )}
        </ActionsSection>
      </DetailsPanelContent>
    </DetailsPanelContainer>
  );
};

// Styled components for the details panel
const DetailsPanelContainer = styled.div`
  position: absolute;
  top: 20px;
  right: 20px;
  width: 320px;
  background: rgba(10, 14, 23, 0.9);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
  backdrop-filter: blur(10px);
  overflow: hidden;
  z-index: 100;
`;

const DetailsPanelHeader = styled.div`
  display: flex;
  align-items: center;
  padding: 12px 16px;
  background: rgba(0, 0, 0, 0.2);
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
`;

const MemoryTypeIndicator = styled.div<{ type: 'session' | 'short_term' | 'long_term' }>`
  width: 12px;
  height: 12px;
  border-radius: 50%;
  margin-right: 12px;
  background-color: ${props => {
    switch (props.type) {
      case 'session': return 'var(--neural-blue)';
      case 'short_term': return 'var(--cyber-teal)';
      case 'long_term': return 'var(--digital-magenta)';
    }
  }};
  box-shadow: 0 0 8px ${props => {
    switch (props.type) {
      case 'session': return 'var(--neural-blue)';
      case 'short_term': return 'var(--cyber-teal)';
      case 'long_term': return 'var(--digital-magenta)';
    }
  }};
`;

const DetailsPanelTitle = styled.h3`
  margin: 0;
  font-family: 'Exo 2', sans-serif;
  font-size: 16px;
  font-weight: 500;
  color: white;
  flex-grow: 1;
`;

const CloseButton = styled.button`
  background: none;
  border: none;
  color: rgba(255, 255, 255, 0.7);
  font-size: 20px;
  cursor: pointer;
  padding: 0;
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  
  &:hover {
    background: rgba(255, 255, 255, 0.1);
    color: white;
  }
`;

const DetailsPanelContent = styled.div`
  padding: 16px;
  max-height: 500px;
  overflow-y: auto;
  
  &::-webkit-scrollbar {
    width: 6px;
  }
  
  &::-webkit-scrollbar-track {
    background: rgba(0, 0, 0, 0.1);
  }
  
  &::-webkit-scrollbar-thumb {
    background: rgba(255, 255, 255, 0.2);
    border-radius: 3px;
  }
`;

const MemoryContent = styled.div`
  font-family: 'Exo 2', sans-serif;
  font-size: 14px;
  line-height: 1.5;
  color: white;
  margin-bottom: 16px;
  padding: 12px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 6px;
  border-left: 3px solid rgba(255, 255, 255, 0.2);
`;

const MetadataSection = styled.div`
  margin-bottom: 16px;
`;

const MetadataItem = styled.div`
  display: flex;
  margin-bottom: 8px;
  align-items: center;
`;

const MetadataLabel = styled.div`
  font-family: 'JetBrains Mono', monospace;
  font-size: 12px;
  color: rgba(255, 255, 255, 0.7);
  width: 110px;
  flex-shrink: 0;
`;

const MetadataValue = styled.div`
  font-family: 'JetBrains Mono', monospace;
  font-size: 12px;
  color: white;
  flex-grow: 1;
`;

const ImportanceBar = styled.div<{ value: number }>`
  height: 6px;
  background: linear-gradient(to right, 
    var(--neural-blue) 0%, 
    var(--cyber-teal) 50%, 
    var(--digital-magenta) 100%
  );
  border-radius: 3px;
  width: ${props => props.value * 100}%;
`;

const SectionTitle = styled.h4`
  font-family: 'Exo 2', sans-serif;
  font-size: 14px;
  font-weight: 500;
  color: white;
  margin: 0 0 8px 0;
`;

const TopicsSection = styled.div`
  margin-bottom: 16px;
`;

const TopicsList = styled.div`
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
`;

const TopicTag = styled.div`
  font-family: 'JetBrains Mono', monospace;
  font-size: 11px;
  color: white;
  background: rgba(255, 255, 255, 0.1);
  padding: 3px 8px;
  border-radius: 12px;
  border: 1px solid rgba(255, 255, 255, 0.2);
`;

const ActionsSection = styled.div`
  display: flex;
  gap: 8px;
  margin-top: 16px;
`;

const ActionButton = styled.button<{ danger?: boolean }>`
  font-family: 'Exo 2', sans-serif;
  font-size: 12px;
  font-weight: 500;
  color: white;
  background: ${props => props.danger 
    ? 'rgba(255, 51, 51, 0.2)' 
    : 'rgba(0, 166, 255, 0.2)'};
  border: 1px solid ${props => props.danger 
    ? 'rgba(255, 51, 51, 0.5)' 
    : 'rgba(0, 166, 255, 0.5)'};
  border-radius: 4px;
  padding: 6px 12px;
  cursor: pointer;
  transition: all 0.2s ease;
  
  &:hover {
    background: ${props => props.danger 
      ? 'rgba(255, 51, 51, 0.3)' 
      : 'rgba(0, 166, 255, 0.3)'};
    border-color: ${props => props.danger 
      ? 'rgba(255, 51, 51, 0.8)' 
      : 'rgba(0, 166, 255, 0.8)'};
  }
`;
```

## Control Panel

A control panel provides options for filtering and manipulating the memory visualization:

```typescript
interface MemoryControlPanelProps {
  viewMode: '2d' | '3d' | 'network';
  onViewModeChange: (mode: '2d' | '3d' | 'network') => void;
  filters: MemoryFilters;
  onFiltersChange: (filters: MemoryFilters) => void;
  onRefresh: () => void;
}

interface MemoryFilters {
  showSessionMemories: boolean;
  showShortTermMemories: boolean;
  showLongTermMemories: boolean;
  timeRange: [Date, Date] | null;
  importanceThreshold: number;
  searchQuery: string;
  selectedTopics: string[];
}

const MemoryControlPanel: React.FC<MemoryControlPanelProps> = ({
  viewMode,
  onViewModeChange,
  filters,
  onFiltersChange,
  onRefresh
}) => {
  return (
    <ControlPanelContainer>
      <ControlPanelSection>
        <SectionTitle>View Mode</SectionTitle>
        <ViewModeSelector>
          <ViewModeButton 
            active={viewMode === '2d'} 
            onClick={() => onViewModeChange('2d')}
          >
            2D Rings
          </ViewModeButton>
          <ViewModeButton 
            active={viewMode === '3d'} 
            onClick={() => onViewModeChange('3d')}
          >
            3D Sphere
          </ViewModeButton>
          <ViewModeButton 
            active={viewMode === 'network'} 
            onClick={() => onViewModeChange('network')}
          >
            Network
          </ViewModeButton>
        </ViewModeSelector>
      </ControlPanelSection>
      
      <ControlPanelSection>
        <SectionTitle>Memory Layers</SectionTitle>
        <CheckboxGroup>
          <CheckboxItem>
            <Checkbox
              checked={filters.showSessionMemories}
              onChange={e => onFiltersChange({
                ...filters,
                showSessionMemories: e.target.checked
              })}
              color="var(--neural-blue)"
            />
            <CheckboxLabel>Session Memory</CheckboxLabel>
          </CheckboxItem>
          <CheckboxItem>
            <Checkbox
              checked={filters.showShortTermMemories}
              onChange={e => onFiltersChange({
                ...filters,
                showShortTermMemories: e.target.checked
              })}
              color="var(--cyber-teal)"
            />
            <CheckboxLabel>Short-Term Memory</CheckboxLabel>
          </CheckboxItem>
          <CheckboxItem>
            <Checkbox
              checked={filters.showLongTermMemories}
              onChange={e => onFiltersChange({
                ...filters,
                showLongTermMemories: e.target.checked
              })}
              color="var(--digital-magenta)"
            />
            <CheckboxLabel>Long-Term Memory</CheckboxLabel>
          </CheckboxItem>
        </CheckboxGroup>
      </ControlPanelSection>
      
      <ControlPanelSection>
        <SectionTitle>Importance Filter</SectionTitle>
        <SliderContainer>
          <Slider
            min={0}
            max={1}
            step={0.01}
            value={filters.importanceThreshold}
            onChange={value => onFiltersChange({
              ...filters,
              importanceThreshold: value
            })}
          />
          <SliderValue>{filters.importanceThreshold.toFixed(2)}</SliderValue>
        </SliderContainer>
      </ControlPanelSection>
      
      <ControlPanelSection>
        <SectionTitle>Search</SectionTitle>
        <SearchInput
          value={filters.searchQuery}
          onChange={e => onFiltersChange({
            ...filters,
            searchQuery: e.target.value
          })}
          placeholder="Search memories..."
        />
      </ControlPanelSection>
      
      <ControlPanelSection>
        <RefreshButton onClick={onRefresh}>
          Refresh Memory System
        </RefreshButton>
      </ControlPanelSection>
    </ControlPanelContainer>
  );
};

// Styled components for the control panel
const ControlPanelContainer = styled.div`
  position: absolute;
  top: 20px;
  left: 20px;
  width: 250px;
  background: rgba(10, 14, 23, 0.9);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
  backdrop-filter: blur(10px);
  overflow: hidden;
  z-index: 100;
`;

const ControlPanelSection = styled.div`
  padding: 12px 16px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
  
  &:last-child {
    border-bottom: none;
  }
`;

const SectionTitle = styled.h4`
  font-family: 'Exo 2', sans-serif;
  font-size: 14px;
  font-weight: 500;
  color: white;
  margin: 0 0 8px 0;
`;

const ViewModeSelector = styled.div`
  display: flex;
  gap: 6px;
`;

const ViewModeButton = styled.button<{ active: boolean }>`
  flex: 1;
  font-family: 'Exo 2', sans-serif;
  font-size: 12px;
  font-weight: 500;
  color: white;
  background: ${props => props.active 
    ? 'rgba(0, 166, 255, 0.3)' 
    : 'rgba(255, 255, 255, 0.05)'};
  border: 1px solid ${props => props.active 
    ? 'rgba(0, 166, 255, 0.8)' 
    : 'rgba(255, 255, 255, 0.1)'};
  border-radius: 4px;
  padding: 6px 0;
  cursor: pointer;
  transition: all 0.2s ease;
  
  &:hover {
    background: ${props => props.active 
      ? 'rgba(0, 166, 255, 0.4)' 
      : 'rgba(255, 255, 255, 0.1)'};
  }
`;

const CheckboxGroup = styled.div`
  display: flex;
  flex-direction: column;
  gap: 8px;
`;

const CheckboxItem = styled.label`
  display: flex;
  align-items: center;
  cursor: pointer;
`;

const Checkbox = styled.input.attrs({ type: 'checkbox' })<{ color: string }>`
  appearance: none;
  width: 16px;
  height: 16px;
  border: 1px solid rgba(255, 255, 255, 0.3);
  border-radius: 3px;
  margin: 0;
  position: relative;
  cursor: pointer;
  
  &:checked {
    background-color: ${props => props.color};
    border-color: ${props => props.color};
  }
  
  &:checked::after {
    content: '';
    position: absolute;
    top: 2px;
    left: 5px;
    width: 4px;
    height: 8px;
    border: solid white;
    border-width: 0 2px 2px 0;
    transform: rotate(45deg);
  }
`;

const CheckboxLabel = styled.span`
  font-family: 'Exo 2', sans-serif;
  font-size: 13px;
  color: white;
  margin-left: 8px;
`;

const SliderContainer = styled.div`
  display: flex;
  align-items: center;
  gap: 12px;
`;

const Slider = styled.input.attrs({ type: 'range' })`
  flex-grow: 1;
  height: 4px;
  background: linear-gradient(to right, 
    var(--neural-blue) 0%, 
    var(--cyber-teal) 50%, 
    var(--digital-magenta) 100%
  );
  border-radius: 2px;
  appearance: none;
  
  &::-webkit-slider-thumb {
    appearance: none;
    width: 14px;
    height: 14px;
    border-radius: 50%;
    background: white;
    cursor: pointer;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.5);
  }
`;

const SliderValue = styled.div`
  font-family: 'JetBrains Mono', monospace;
  font-size: 12px;
  color: white;
  width: 36px;
  text-align: right;
`;

const SearchInput = styled.input`
  width: 100%;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 4px;
  padding: 8px 12px;
  font-family: 'Exo 2', sans-serif;
  font-size: 13px;
  color: white;
  outline: none;
  
  &:focus {
    border-color: rgba(0, 166, 255, 0.5);
    box-shadow: 0 0 0 1px rgba(0, 166, 255, 0.2);
  }
  
  &::placeholder {
    color: rgba(255, 255, 255, 0.4);
  }
`;

const RefreshButton = styled.button`
  width: 100%;
  font-family: 'Exo 2', sans-serif;
  font-size: 13px;
  font-weight: 500;
  color: white;
  background: rgba(0, 166, 255, 0.2);
  border: 1px solid rgba(0, 166, 255, 0.5);
  border-radius: 4px;
  padding: 8px 0;
  cursor: pointer;
  transition: all 0.2s ease;
  
  &:hover {
    background: rgba(0, 166, 255, 0.3);
  }
`;
```

## Animation System

### CSS Animations

```css
/* Pulse animation for active nodes */
@keyframes pulse {
  0% {
    transform: scale(1);
    opacity: 0.5;
  }
  50% {
    transform: scale(1.5);
    opacity: 0.2;
  }
  100% {
    transform: scale(1);
    opacity: 0.5;
  }
}

.pulse-animation {
  animation: pulse 2s infinite ease-in-out;
}

/* Connection pulse animation */
@keyframes connectionPulse {
  0% {
    opacity: 0.8;
  }
  100% {
    opacity: 0.2;
  }
}

.connection-pulse {
  animation: connectionPulse 1.5s infinite alternate ease-in-out;
}

/* Memory formation animation */
@keyframes formationGlow {
  0% {
    filter: blur(2px);
    opacity: 0.3;
  }
  50% {
    filter: blur(5px);
    opacity: 0.6;
  }
  100% {
    filter: blur(2px);
    opacity: 0.3;
  }
}

.formation-process {
  animation: formationGlow 2s infinite ease-in-out;
}
```

### React Spring Animations

```typescript
// Using react-spring for smooth transitions
const MemoryNode: React.FC<MemoryNodeProps> = ({
  memory,
  onSelect,
  onHover,
  isActive = false
}) => {
  const nodeColor = getMemoryTypeColor(memory.type);
  const glowIntensity = calculateGlowIntensity(memory);
  
  // Animate node properties
  const springProps = useSpring({
    radius: memory.radius,
    x: memory.x,
    y: memory.y,
    glowOpacity: 0.1 * glowIntensity,
    nodeOpacity: isActive ? 0.9 : 0.7,
    strokeWidth: isActive ? 2 : 1,
    config: { tension: 120, friction: 14 }
  });
  
  return (
    <g
      className={`memory-node ${memory.type} ${isActive ? 'active' : ''}`}
      onClick={() => onSelect(memory.id)}
      onMouseEnter={() => onHover(memory.id)}
      onMouseLeave={() => onHover(null)}
    >
      {/* Glow effect */}
      <animated.circle
        cx={springProps.x}
        cy={springProps.y}
        r={springProps.radius.to(r => r * 2)}
        fill={nodeColor}
        opacity={springProps.glowOpacity}
        filter="blur(5px)"
      />
      
      {/* Main node */}
      <animated.circle
        cx={springProps.x}
        cy={springProps.y}
        r={springProps.radius}
        fill={nodeColor}
        opacity={springProps.nodeOpacity}
        stroke={isActive ? 'white' : nodeColor}
        strokeWidth={springProps.strokeWidth}
      />
      
      {/* Pulse animation for active nodes */}
      {isActive && (
        <animated.circle
          cx={springProps.x}
          cy={springProps.y}
          r={springProps.radius.to(r => r * 1.5)}
          fill="none"
          stroke={nodeColor}
          strokeWidth="1"
          opacity="0.5"
          className="pulse-animation"
        />
      )}
    </g>
  );
};
```

## Responsive Behavior

The visualization adapts to different screen sizes:

```typescript
const MemorySystemVisualization: React.FC<MemorySystemVisualizationProps> = (props) => {
  const containerRef = useRef<HTMLDivElement>(null);
  const [dimensions, setDimensions] = useState({ width: 800, height: 600 });
  const isMobile = useMediaQuery('(max-width: 768px)');
  
  // Update dimensions on resize
  useEffect(() => {
    const updateDimensions = () => {
      if (containerRef.current) {
        setDimensions({
          width: containerRef.current.clientWidth,
          height: containerRef.current.clientHeight
        });
      }
    };
    
    updateDimensions();
    
    const resizeObserver = new ResizeObserver(updateDimensions);
    if (containerRef.current) {
      resizeObserver.observe(containerRef.current);
    }
    
    return () => {
      resizeObserver.disconnect();
    };
  }, []);
  
  // Adjust view based on screen size
  const adjustedProps = useMemo(() => {
    if (isMobile) {
      return {
        ...props,
        showLabels: false,
        viewMode: props.viewMode === '3d' ? '2d' : props.viewMode // Fallback to 2D on mobile
      };
    }
    return props;
  }, [props, isMobile]);
  
  return (
    <VisualizationContainer ref={containerRef}>
      {adjustedProps.viewMode === '2d' && (
        <ConcentricRingsView
          {...adjustedProps}
          width={dimensions.width}
          height={dimensions.height}
        />
      )}
      {adjustedProps.viewMode === '3d' && (
        <SphericalView
          {...adjustedProps}
          width={dimensions.width}
          height={dimensions.height}
        />
      )}
      {adjustedProps.viewMode === 'network' && (
        <NetworkView
          {...adjustedProps}
          width={dimensions.width}
          height={dimensions.height}
        />
      )}
      
      {/* Controls and panels */}
      {!isMobile && (
        <MemoryControlPanel
          viewMode={adjustedProps.viewMode}
          onViewModeChange={props.onViewChange}
          filters={props.filters}
          onFiltersChange={props.onFiltersChange}
          onRefresh={props.onRefresh}
        />
      )}
      
      {/* Mobile controls (simplified) */}
      {isMobile && (
        <MobileControls
          viewMode={adjustedProps.viewMode}
          onViewModeChange={props.onViewChange}
          onRefresh={props.onRefresh}
        />
      )}
      
      {/* Memory details panel */}
      {props.focusedMemoryId && (
        <MemoryDetailsPanel
          memory={findMemoryById(props.focusedMemoryId, props)}
          onClose={() => props.onMemorySelect('')}
          onPromote={props.onMemoryPromote}
          onDelete={props.onMemoryDelete}
        />
      )}
    </VisualizationContainer>
  );
};

// Helper function to find memory by ID
const findMemoryById = (
  id: string,
  props: MemorySystemVisualizationProps
): Memory | null => {
  const allMemories = [
    ...props.sessionMemories,
    ...props.shortTermMemories,
    ...props.longTermMemories
  ];
  
  return allMemories.find(memory => memory.id === id) || null;
};

// Mobile controls component
const MobileControls: React.FC<{
  viewMode: '2d' | '3d' | 'network';
  onViewModeChange: (mode: '2d' | '3d' | 'network') => void;
  onRefresh: () => void;
}> = ({ viewMode, onViewModeChange, onRefresh }) => {
  return (
    <MobileControlsContainer>
      <MobileViewToggle>
        <ViewModeButton 
          active={viewMode === '2d'} 
          onClick={() => onViewModeChange('2d')}
        >
          2D
        </ViewModeButton>
        <ViewModeButton 
          active={viewMode === 'network'} 
          onClick={() => onViewModeChange('network')}
        >
          Net
        </ViewModeButton>
      </MobileViewToggle>
      <MobileRefreshButton onClick={onRefresh}>
        ↻
      </MobileRefreshButton>
    </MobileControlsContainer>
  );
};

const MobileControlsContainer = styled.div`
  position: absolute;
  bottom: 20px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 12px;
  align-items: center;
  background: rgba(10, 14, 23, 0.9);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  padding: 6px;
  backdrop-filter: blur(10px);
  z-index: 100;
`;

const MobileViewToggle = styled.div`
  display: flex;
  gap: 4px;
`;

const MobileRefreshButton = styled.button`
  width: 32px;
  height: 32px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  color: white;
  background: rgba(0, 166, 255, 0.2);
  border: 1px solid rgba(0, 166, 255, 0.5);
  cursor: pointer;
`;
```

## Accessibility Considerations

### Keyboard Navigation

```typescript
const MemorySystemVisualization: React.FC<MemorySystemVisualizationProps> = (props) => {
  // ... other code
  
  // Keyboard navigation state
  const [focusedIndex, setFocusedIndex] = useState(-1);
  const allMemories = useMemo(() => [
    ...props.sessionMemories,
    ...props.shortTermMemories,
    ...props.longTermMemories
  ], [props.sessionMemories, props.shortTermMemories, props.longTermMemories]);
  
  // Handle keyboard navigation
  const handleKeyDown = useCallback((e: React.KeyboardEvent) => {
    switch (e.key) {
      case 'ArrowRight':
      case 'ArrowDown':
        setFocusedIndex(prev => (prev + 1) % allMemories.length);
        break;
      case 'ArrowLeft':
      case 'ArrowUp':
        setFocusedIndex(prev => (prev - 1 + allMemories.length) % allMemories.length);
        break;
      case 'Enter':
      case ' ':
        if (focusedIndex >= 0 && focusedIndex < allMemories.length) {
          props.onMemorySelect(allMemories[focusedIndex].id);
        }
        break;
      case 'Escape':
        if (props.focusedMemoryId) {
          props.onMemorySelect('');
        }
        break;
    }
  }, [allMemories, focusedIndex, props]);
  
  return (
    <VisualizationContainer 
      ref={containerRef}
      tabIndex={0}
      onKeyDown={handleKeyDown}
      role="application"
      aria-label="Memory System Visualization"
    >
      {/* ... visualization content */}
    </VisualizationContainer>
  );
};
```

### Screen Reader Support

```typescript
const MemoryNode: React.FC<MemoryNodeProps> = ({
  memory,
  onSelect,
  onHover,
  isActive = false
}) => {
  // ... other code
  
  return (
    <g
      className={`memory-node ${memory.type} ${isActive ? 'active' : ''}`}
      onClick={() => onSelect(memory.id)}
      onMouseEnter={() => onHover(memory.id)}
      onMouseLeave={() => onHover(null)}
      role="button"
      aria-label={`${memory.type} memory: ${memory.content.substring(0, 50)}${memory.content.length > 50 ? '...' : ''}`}
      aria-pressed={isActive}
      tabIndex={0}
    >
      {/* ... node visualization */}
    </g>
  );
};
```

### Focus Indicators

```css
.memory-node:focus-visible {
  outline: 2px solid white;
  outline-offset: 2px;
}

.control-panel button:focus-visible,
.control-panel input:focus-visible {
  outline: 2px solid var(--neural-blue);
  outline-offset: 2px;
}
```

## Usage Example

```tsx
// In the main system metrics panel
const SystemMetricsPanel = () => {
  const dispatch = useDispatch();
  const {
    sessionMemories,
    shortTermMemories,
    longTermMemories,
    connections,
    activeProcesses,
    filters,
    focusedMemoryId
  } = useSelector(selectMemorySystemState);
  
  const handleMemorySelect = useCallback((memoryId: string) => {
    dispatch(selectMemory(memoryId));
  }, [dispatch]);
  
  const handleMemoryHover = useCallback((memoryId: string | null) => {
    dispatch(hoverMemory(memoryId));
  }, [dispatch]);
  
  const handleViewChange = useCallback((viewMode: '2d' | '3d' | 'network') => {
    dispatch(setMemoryViewMode(viewMode));
  }, [dispatch]);
  
  const handleFiltersChange = useCallback((newFilters: MemoryFilters) => {
    dispatch(setMemoryFilters(newFilters));
  }, [dispatch]);
  
  const handleRefresh = useCallback(() => {
    dispatch(refreshMemorySystem());
  }, [dispatch]);
  
  const handleMemoryPromote = useCallback((memoryId: string) => {
    dispatch(promoteMemory(memoryId));
  }, [dispatch]);
  
  const handleMemoryDelete = useCallback((memoryId: string) => {
    dispatch(deleteMemory(memoryId));
  }, [dispatch]);
  
  return (
    <MetricsPanel>
      <PanelHeader>Memory System</PanelHeader>
      <MemorySystemContainer>
        <MemorySystemVisualization
          sessionMemories={sessionMemories}
          shortTermMemories={shortTermMemories}
          longTermMemories={longTermMemories}
          connections={connections}
          activeProcesses={activeProcesses}
          viewMode={filters.viewMode}
          showLabels={filters.showLabels}
          focusedMemoryId={focusedMemoryId}
          filters={filters}
          onMemorySelect={handleMemorySelect}
          onMemoryHover={handleMemoryHover}
          onViewChange={handleViewChange}
          onFiltersChange={handleFiltersChange}
          onRefresh={handleRefresh}
          onMemoryPromote={handleMemoryPromote}
          onMemoryDelete={handleMemoryDelete}
        />
      </MemorySystemContainer>
    </MetricsPanel>
  );
};
```

## Future Enhancements

### Advanced 3D Visualization
- Full 3D memory palace with navigable spaces
- VR/AR compatibility for immersive exploration
- Spatial audio cues for memory activation

### Memory Formation Visualization
- Visual representation of memory encoding process
- Neural network training visualization for new memories
- Importance calculation visualization

### Collaborative Memory Exploration
- Multi-user memory exploration
- Shared annotations and highlights
- Collaborative memory organization

### Advanced Memory Analytics
- Memory usage patterns visualization
- Topic clustering and trend analysis
- Temporal memory evolution visualization