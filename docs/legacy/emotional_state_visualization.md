# Emotional State Visualization Component

## Overview

The Emotional State Visualization component provides a dynamic, visual representation of Thalia's current emotional state based on the PAD (Pleasure-Arousal-Dominance) emotional model. This component transforms abstract emotional data into an engaging, intuitive visualization that helps users understand Thalia's emotional responses and internal state.

## Emotional Model

### PAD Model Implementation

The PAD model represents emotions along three dimensions:

1. **Pleasure (P)**: Represents positive vs. negative affect
   - Range: -1.0 (extreme displeasure) to 1.0 (extreme pleasure)
   - Visual mapping: Color spectrum from cool to warm

2. **Arousal (A)**: Represents activation level/intensity
   - Range: 0.0 (minimal arousal) to 1.0 (maximum arousal)
   - Visual mapping: Animation speed and particle density

3. **Dominance (D)**: Represents feeling of control/influence
   - Range: 0.0 (submissive) to 1.0 (dominant)
   - Visual mapping: Visual size and expansion

### Emotional States Mapping

Common emotional states mapped to PAD coordinates:

| Emotion      | Pleasure | Arousal | Dominance |
|--------------|----------|---------|-----------|
| Joy          |  0.76    |  0.48   |  0.35     |
| Excitement   |  0.62    |  0.82   |  0.43     |
| Contentment  |  0.82    |  0.18   |  0.63     |
| Sadness      | -0.63    |  0.27   | -0.33     |
| Anger        | -0.51    |  0.59   |  0.25     |
| Fear         | -0.64    |  0.60   | -0.43     |
| Interest     |  0.39    |  0.41   |  0.16     |
| Surprise     |  0.40    |  0.67   | -0.13     |
| Confusion    | -0.05    |  0.32   | -0.26     |
| Contemplation|  0.11    |  0.22   |  0.41     |

## Visual Design

### Core Concept: Emotional Particle System

The emotional state is visualized as a dynamic particle system that responds to changes in the PAD values:

- **Particles**: Individual elements that represent emotional energy
- **Flow**: Movement patterns that reflect emotional qualities
- **Color**: Spectrum that represents the pleasure dimension
- **Density/Speed**: Variations that represent the arousal dimension
- **Scale/Expansion**: Characteristics that represent the dominance dimension

### Visual Elements

#### Particle Characteristics
- **Base Shape**: Soft, circular particles with subtle glow
- **Size Range**: 2px to 8px, varying based on dominance
- **Opacity**: 30% to 80%, varying based on intensity
- **Blur**: Subtle Gaussian blur for ethereal quality

#### Color Mapping (Pleasure Dimension)
- **High Pleasure**: Warm colors (magenta, pink, gold)
  - P = 1.0: `#FF00A6` (Digital Magenta)
  - P = 0.5: `#FF6EB4` (Rose Pink)
- **Neutral**: Balanced colors (purples, teals)
  - P = 0.0: `#9966FF` (Medium Purple)
- **Low Pleasure**: Cool colors (blues, cyans)
  - P = -0.5: `#00A6FF` (Neural Blue)
  - P = -1.0: `#0066CC` (Deep Blue)

#### Movement Patterns (Arousal Dimension)
- **High Arousal**: Rapid, energetic movement
  - Faster particle velocity
  - More directional changes
  - Higher turbulence
- **Medium Arousal**: Moderate, flowing movement
  - Balanced velocity
  - Gentle curves and flows
  - Moderate turbulence
- **Low Arousal**: Slow, calm movement
  - Slower particle velocity
  - Smoother, more predictable paths
  - Minimal turbulence

#### Scale and Form (Dominance Dimension)
- **High Dominance**: Expansive, bold presence
  - Larger particle size
  - Wider field of effect
  - More defined structure
- **Medium Dominance**: Balanced presence
  - Medium particle size
  - Moderate field of effect
  - Semi-structured patterns
- **Low Dominance**: Contained, subtle presence
  - Smaller particle size
  - Narrower field of effect
  - More diffuse structure

### Composite Emotional Representations

The system combines these elements to create recognizable emotional states:

- **Joy**: Warm colors, moderate movement, medium expansion
- **Excitement**: Bright warm colors, rapid movement, medium expansion
- **Contentment**: Soft warm colors, slow movement, medium-high expansion
- **Sadness**: Cool colors, slow movement, low expansion
- **Anger**: Intense cool colors, rapid movement, high expansion
- **Fear**: Dark cool colors, rapid erratic movement, low expansion

## Interaction Design

### User Interaction
- **Hover**: Reveals detailed emotional metrics and labels
- **Click**: Expands the visualization with additional information
- **Long Press**: Opens emotional history view

### Transitions
- **Smooth Transitions**: Emotional states blend smoothly rather than jumping
- **Transition Speed**: Changes based on the emotional shift magnitude
- **History Trail**: Optional visualization showing recent emotional changes

### Integration with Conversation
- **Response Correlation**: Subtle pulses synchronized with Thalia's responses
- **Emotional Triggers**: Visual highlights when specific topics affect emotions
- **Contextual Reactions**: Micro-reactions to user messages

## Technical Implementation

### Component Structure

```typescript
interface EmotionalStateVisualizationProps {
  // PAD model values
  pleasure: number;  // Range: -1.0 to 1.0
  arousal: number;   // Range: 0.0 to 1.0
  dominance: number; // Range: 0.0 to 1.0
  
  // Optional properties
  size?: 'small' | 'medium' | 'large';
  showLabels?: boolean;
  showMetrics?: boolean;
  historyLength?: number;
  onInteraction?: (type: 'hover' | 'click' | 'longPress') => void;
}

const EmotionalStateVisualization: React.FC<EmotionalStateVisualizationProps> = ({
  pleasure,
  arousal,
  dominance,
  size = 'medium',
  showLabels = false,
  showMetrics = false,
  historyLength = 0,
  onInteraction
}) => {
  // Component implementation
};
```

### Particle System Implementation

The core visualization uses HTML Canvas with requestAnimationFrame for performance:

```typescript
const EmotionalParticleSystem: React.FC<{
  pleasure: number;
  arousal: number;
  dominance: number;
  width: number;
  height: number;
}> = ({ pleasure, arousal, dominance, width, height }) => {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const particles = useRef<Particle[]>([]);
  
  // Initialize particles on mount
  useEffect(() => {
    const particleCount = Math.floor(50 + dominance * 50);
    particles.current = Array.from({ length: particleCount }, () => createParticle());
    
    return () => {
      // Cleanup
    };
  }, [dominance]);
  
  // Animation loop
  useEffect(() => {
    let animationFrameId: number;
    
    const render = () => {
      const canvas = canvasRef.current;
      if (!canvas) return;
      
      const ctx = canvas.getContext('2d');
      if (!ctx) return;
      
      // Clear canvas
      ctx.clearRect(0, 0, width, height);
      
      // Update and draw particles
      particles.current.forEach(particle => {
        // Update position based on arousal
        const speed = 0.5 + arousal * 2;
        particle.x += particle.vx * speed;
        particle.y += particle.vy * speed;
        
        // Boundary check with wrapping
        if (particle.x < 0) particle.x = width;
        if (particle.x > width) particle.x = 0;
        if (particle.y < 0) particle.y = height;
        if (particle.y > height) particle.y = 0;
        
        // Apply turbulence based on arousal
        const turbulence = arousal * 0.1;
        particle.vx += (Math.random() - 0.5) * turbulence;
        particle.vy += (Math.random() - 0.5) * turbulence;
        
        // Normalize velocity
        const speed = Math.sqrt(particle.vx * particle.vx + particle.vy * particle.vy);
        if (speed > 0) {
          particle.vx = (particle.vx / speed) * (0.5 + arousal);
          particle.vy = (particle.vy / speed) * (0.5 + arousal);
        }
        
        // Calculate color based on pleasure
        const color = getColorFromPleasure(pleasure);
        
        // Calculate size based on dominance
        const size = 2 + (dominance * 6);
        
        // Draw particle
        ctx.beginPath();
        ctx.arc(particle.x, particle.y, size, 0, Math.PI * 2);
        ctx.fillStyle = color;
        ctx.globalAlpha = 0.3 + (particle.life * 0.5);
        ctx.fill();
        
        // Update particle life
        particle.life -= 0.01;
        if (particle.life <= 0) {
          // Reset particle
          Object.assign(particle, createParticle());
        }
      });
      
      animationFrameId = requestAnimationFrame(render);
    };
    
    render();
    
    return () => {
      cancelAnimationFrame(animationFrameId);
    };
  }, [pleasure, arousal, dominance, width, height]);
  
  return (
    <canvas
      ref={canvasRef}
      width={width}
      height={height}
      style={{ width, height }}
    />
  );
};

// Helper function to create a particle
const createParticle = (): Particle => ({
  x: Math.random() * width,
  y: Math.random() * height,
  vx: (Math.random() - 0.5) * 2,
  vy: (Math.random() - 0.5) * 2,
  life: Math.random() * 0.5 + 0.5
});

// Helper function to get color from pleasure value
const getColorFromPleasure = (pleasure: number): string => {
  if (pleasure >= 0) {
    // Pleasure: 0 to 1 (Purple to Magenta)
    const r = Math.round(153 + pleasure * 102);
    const g = Math.round(102 - pleasure * 102);
    const b = Math.round(255 - pleasure * 110);
    return `rgb(${r}, ${g}, ${b})`;
  } else {
    // Pleasure: -1 to 0 (Blue to Purple)
    const normalizedPleasure = pleasure + 1; // 0 to 1
    const r = Math.round(0 + normalizedPleasure * 153);
    const g = Math.round(102 + normalizedPleasure * 0);
    const b = Math.round(204 + normalizedPleasure * 51);
    return `rgb(${r}, ${g}, ${b})`;
  }
};
```

### Emotional Labels and Metrics

When labels or metrics are enabled, they are rendered as overlays:

```typescript
const EmotionalLabels: React.FC<{
  pleasure: number;
  arousal: number;
  dominance: number;
}> = ({ pleasure, arousal, dominance }) => {
  const emotionalState = determineEmotionalState(pleasure, arousal, dominance);
  
  return (
    <LabelsContainer>
      <PrimaryLabel>{emotionalState}</PrimaryLabel>
      {showMetrics && (
        <MetricsContainer>
          <Metric>P: {pleasure.toFixed(2)}</Metric>
          <Metric>A: {arousal.toFixed(2)}</Metric>
          <Metric>D: {dominance.toFixed(2)}</Metric>
        </MetricsContainer>
      )}
    </LabelsContainer>
  );
};

// Helper function to determine emotional state from PAD values
const determineEmotionalState = (
  pleasure: number,
  arousal: number,
  dominance: number
): string => {
  // Calculate distance to known emotional states
  const emotions = [
    { name: 'Joy', p: 0.76, a: 0.48, d: 0.35 },
    { name: 'Excitement', p: 0.62, a: 0.82, d: 0.43 },
    { name: 'Contentment', p: 0.82, a: 0.18, d: 0.63 },
    { name: 'Sadness', p: -0.63, a: 0.27, d: -0.33 },
    { name: 'Anger', p: -0.51, a: 0.59, d: 0.25 },
    { name: 'Fear', p: -0.64, a: 0.60, d: -0.43 },
    { name: 'Interest', p: 0.39, a: 0.41, d: 0.16 },
    { name: 'Surprise', p: 0.40, a: 0.67, d: -0.13 },
    { name: 'Confusion', p: -0.05, a: 0.32, d: -0.26 },
    { name: 'Contemplation', p: 0.11, a: 0.22, d: 0.41 },
  ];
  
  // Find closest emotion
  let closestEmotion = emotions[0];
  let minDistance = Number.MAX_VALUE;
  
  emotions.forEach(emotion => {
    const distance = Math.sqrt(
      Math.pow(pleasure - emotion.p, 2) +
      Math.pow(arousal - emotion.a, 2) +
      Math.pow(dominance - emotion.d, 2)
    );
    
    if (distance < minDistance) {
      minDistance = distance;
      closestEmotion = emotion;
    }
  });
  
  return closestEmotion.name;
};
```

### Emotional History Visualization

When history tracking is enabled:

```typescript
interface EmotionalHistoryProps {
  history: Array<{
    pleasure: number;
    arousal: number;
    dominance: number;
    timestamp: number;
  }>;
  width: number;
  height: number;
}

const EmotionalHistory: React.FC<EmotionalHistoryProps> = ({
  history,
  width,
  height
}) => {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  
  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    if (!ctx) return;
    
    // Clear canvas
    ctx.clearRect(0, 0, width, height);
    
    // Draw history as a path
    if (history.length > 1) {
      // Plot pleasure over time
      ctx.beginPath();
      ctx.moveTo(0, height / 2 - (history[0].pleasure * height / 2));
      
      history.forEach((point, index) => {
        const x = (index / (history.length - 1)) * width;
        const y = height / 2 - (point.pleasure * height / 2);
        ctx.lineTo(x, y);
      });
      
      ctx.strokeStyle = 'rgba(255, 0, 166, 0.8)';
      ctx.lineWidth = 2;
      ctx.stroke();
      
      // Plot arousal over time
      ctx.beginPath();
      ctx.moveTo(0, height - (history[0].arousal * height));
      
      history.forEach((point, index) => {
        const x = (index / (history.length - 1)) * width;
        const y = height - (point.arousal * height);
        ctx.lineTo(x, y);
      });
      
      ctx.strokeStyle = 'rgba(0, 166, 255, 0.8)';
      ctx.lineWidth = 2;
      ctx.stroke();
      
      // Plot dominance over time
      ctx.beginPath();
      ctx.moveTo(0, height - (history[0].dominance * height));
      
      history.forEach((point, index) => {
        const x = (index / (history.length - 1)) * width;
        const y = height - (point.dominance * height);
        ctx.lineTo(x, y);
      });
      
      ctx.strokeStyle = 'rgba(0, 255, 209, 0.8)';
      ctx.lineWidth = 2;
      ctx.stroke();
    }
  }, [history, width, height]);
  
  return (
    <HistoryContainer>
      <canvas
        ref={canvasRef}
        width={width}
        height={height}
        style={{ width, height }}
      />
      <HistoryLegend>
        <LegendItem color="var(--digital-magenta)">Pleasure</LegendItem>
        <LegendItem color="var(--neural-blue)">Arousal</LegendItem>
        <LegendItem color="var(--cyber-teal)">Dominance</LegendItem>
      </HistoryLegend>
    </HistoryContainer>
  );
};
```

### Styled Components

```typescript
const VisualizationContainer = styled.div<{ size: 'small' | 'medium' | 'large' }>`
  position: relative;
  border-radius: 50%;
  overflow: hidden;
  background: rgba(10, 14, 23, 0.7);
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
  
  ${props => props.size === 'small' && css`
    width: 80px;
    height: 80px;
  `}
  
  ${props => props.size === 'medium' && css`
    width: 160px;
    height: 160px;
  `}
  
  ${props => props.size === 'large' && css`
    width: 240px;
    height: 240px;
  `}
`;

const LabelsContainer = styled.div`
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  pointer-events: none;
  z-index: 2;
`;

const PrimaryLabel = styled.div`
  font-family: 'Exo 2', sans-serif;
  font-weight: 500;
  color: white;
  text-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  font-size: 1.2rem;
  margin-bottom: 0.5rem;
`;

const MetricsContainer = styled.div`
  display: flex;
  gap: 0.5rem;
`;

const Metric = styled.div`
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.7rem;
  color: rgba(255, 255, 255, 0.8);
  background: rgba(0, 0, 0, 0.3);
  padding: 0.1rem 0.3rem;
  border-radius: 3px;
`;

const HistoryContainer = styled.div`
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 40%;
  background: rgba(0, 0, 0, 0.2);
  border-top: 1px solid rgba(255, 255, 255, 0.1);
`;

const HistoryLegend = styled.div`
  position: absolute;
  top: 5px;
  right: 5px;
  display: flex;
  flex-direction: column;
  gap: 2px;
`;

const LegendItem = styled.div<{ color: string }>`
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.6rem;
  color: white;
  display: flex;
  align-items: center;
  gap: 3px;
  
  &::before {
    content: '';
    display: block;
    width: 8px;
    height: 2px;
    background: ${props => props.color};
  }
`;
```

## Animation System

### Transition Animations

Smooth transitions between emotional states:

```typescript
const EmotionalStateVisualization: React.FC<EmotionalStateVisualizationProps> = ({
  pleasure,
  arousal,
  dominance,
  // other props
}) => {
  // Use spring animations for smooth transitions
  const animatedValues = useSpring({
    pleasure,
    arousal,
    dominance,
    config: { tension: 120, friction: 14 }
  });
  
  return (
    <VisualizationContainer size={size}>
      <EmotionalParticleSystem
        pleasure={animatedValues.pleasure}
        arousal={animatedValues.arousal}
        dominance={animatedValues.dominance}
        width={containerSize}
        height={containerSize}
      />
      {/* Other components */}
    </VisualizationContainer>
  );
};
```

### Pulse Effects

Synchronized pulses with conversation:

```typescript
const PulseEffect: React.FC<{ active: boolean }> = ({ active }) => {
  const pulseAnimation = useSpring({
    from: { scale: 1, opacity: 0.7 },
    to: { scale: active ? 1.2 : 1, opacity: active ? 0 : 0.7 },
    config: { tension: 200, friction: 20 },
    reset: active,
  });
  
  return (
    <animated.div
      style={{
        position: 'absolute',
        top: 0,
        left: 0,
        width: '100%',
        height: '100%',
        borderRadius: '50%',
        background: 'radial-gradient(circle, rgba(255,255,255,0.2) 0%, rgba(255,255,255,0) 70%)',
        transform: pulseAnimation.scale.to(s => `scale(${s})`),
        opacity: pulseAnimation.opacity,
      }}
    />
  );
};
```

### Ambient Animations

Subtle background animations that run continuously:

```typescript
const AmbientBackground: React.FC<{
  pleasure: number;
  arousal: number;
}> = ({ pleasure, arousal }) => {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  
  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    if (!ctx) return;
    
    let animationFrameId: number;
    let time = 0;
    
    const render = () => {
      time += 0.01;
      
      // Clear canvas
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      
      // Draw ambient background
      const gradient = ctx.createRadialGradient(
        canvas.width / 2,
        canvas.height / 2,
        0,
        canvas.width / 2,
        canvas.height / 2,
        canvas.width / 2
      );
      
      // Color based on pleasure
      const baseColor = getColorFromPleasure(pleasure);
      gradient.addColorStop(0, baseColor);
      gradient.addColorStop(1, 'rgba(10, 14, 23, 0.5)');
      
      ctx.fillStyle = gradient;
      ctx.fillRect(0, 0, canvas.width, canvas.height);
      
      // Draw ambient waves
      const waveCount = 3;
      const waveSpeed = 0.5 + arousal * 1.5;
      
      for (let i = 0; i < waveCount; i++) {
        ctx.beginPath();
        
        for (let x = 0; x < canvas.width; x += 5) {
          const normalizedX = x / canvas.width;
          const amplitude = (20 + arousal * 30) * (1 - i / waveCount);
          const period = (0.1 + arousal * 0.2) * (i + 1);
          const phase = time * waveSpeed * (i + 1);
          
          const y = canvas.height / 2 + 
                   Math.sin(normalizedX * Math.PI * 2 * period + phase) * amplitude;
          
          if (x === 0) {
            ctx.moveTo(x, y);
          } else {
            ctx.lineTo(x, y);
          }
        }
        
        ctx.strokeStyle = `rgba(255, 255, 255, ${0.1 - i * 0.03})`;
        ctx.lineWidth = 2;
        ctx.stroke();
      }
      
      animationFrameId = requestAnimationFrame(render);
    };
    
    render();
    
    return () => {
      cancelAnimationFrame(animationFrameId);
    };
  }, [pleasure, arousal]);
  
  return (
    <canvas
      ref={canvasRef}
      width={200}
      height={200}
      style={{
        position: 'absolute',
        top: 0,
        left: 0,
        width: '100%',
        height: '100%',
        zIndex: -1,
      }}
    />
  );
};
```

## Responsive Behavior

The visualization adapts to different screen sizes and contexts:

### Size Variants

```typescript
const getSizeValues = (size: 'small' | 'medium' | 'large') => {
  switch (size) {
    case 'small':
      return {
        containerSize: 80,
        particleCount: 30,
        showLabels: false,
      };
    case 'medium':
      return {
        containerSize: 160,
        particleCount: 60,
        showLabels: true,
      };
    case 'large':
      return {
        containerSize: 240,
        particleCount: 100,
        showLabels: true,
      };
  }
};
```

### Mobile Optimization

```typescript
const useResponsiveConfig = (size: 'small' | 'medium' | 'large') => {
  const isMobile = useMediaQuery('(max-width: 768px)');
  
  return useMemo(() => {
    const baseConfig = getSizeValues(size);
    
    if (isMobile) {
      return {
        ...baseConfig,
        particleCount: Math.floor(baseConfig.particleCount * 0.6), // Reduce particles on mobile
        showLabels: size !== 'small', // Only show labels on medium and large
      };
    }
    
    return baseConfig;
  }, [size, isMobile]);
};
```

### Compact Mode

```typescript
const CompactEmotionalState: React.FC<{
  pleasure: number;
  arousal: number;
  dominance: number;
}> = ({ pleasure, arousal, dominance }) => {
  const emotionalState = determineEmotionalState(pleasure, arousal, dominance);
  const color = getColorFromPleasure(pleasure);
  
  return (
    <CompactContainer>
      <CompactIndicator style={{ backgroundColor: color }} />
      <CompactLabel>{emotionalState}</CompactLabel>
    </CompactContainer>
  );
};

const CompactContainer = styled.div`
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 4px 8px;
  background: rgba(10, 14, 23, 0.7);
  border-radius: 12px;
  height: 24px;
`;

const CompactIndicator = styled.div`
  width: 12px;
  height: 12px;
  border-radius: 50%;
  box-shadow: 0 0 8px currentColor;
`;

const CompactLabel = styled.div`
  font-family: 'Exo 2', sans-serif;
  font-size: 0.8rem;
  color: white;
`;
```

## Accessibility Considerations

### Screen Reader Support

```typescript
<VisualizationContainer 
  size={size}
  role="img"
  aria-label={`Thalia's emotional state is ${determineEmotionalState(pleasure, arousal, dominance)}`}
>
  {/* Visualization content */}
</VisualizationContainer>
```

### Reduced Motion Support

```typescript
const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

// In the particle system
const speed = prefersReducedMotion 
  ? 0.1 + arousal * 0.2  // Significantly reduced speed
  : 0.5 + arousal * 2;   // Normal speed
```

### Alternative Text Representation

```typescript
const TextualEmotionalState: React.FC<{
  pleasure: number;
  arousal: number;
  dominance: number;
}> = ({ pleasure, arousal, dominance }) => {
  const emotionalState = determineEmotionalState(pleasure, arousal, dominance);
  
  // Generate textual description
  const pleasureDesc = pleasure > 0.3 
    ? 'positive' 
    : pleasure < -0.3 
      ? 'negative' 
      : 'neutral';
      
  const arousalDesc = arousal > 0.7 
    ? 'highly energetic' 
    : arousal > 0.3 
      ? 'moderately energetic' 
      : 'calm';
      
  const dominanceDesc = dominance > 0.7 
    ? 'very confident' 
    : dominance > 0.3 
      ? 'moderately confident' 
      : 'uncertain';
  
  return (
    <TextDescription>
      Thalia is feeling {emotionalState}, with a {pleasureDesc}, {arousalDesc}, 
      and {dominanceDesc} emotional state.
    </TextDescription>
  );
};
```

## Usage Example

```tsx
// In the system metrics panel
const SystemMetricsPanel = () => {
  const emotionalState = useSelector(selectEmotionalState);
  const [showHistory, setShowHistory] = useState(false);
  const [size, setSize] = useState<'small' | 'medium' | 'large'>('medium');
  
  const handleInteraction = useCallback((type: 'hover' | 'click' | 'longPress') => {
    if (type === 'click') {
      setSize(size === 'medium' ? 'large' : 'medium');
    } else if (type === 'longPress') {
      setShowHistory(!showHistory);
    }
  }, [size, showHistory]);
  
  return (
    <MetricsPanel>
      <PanelHeader>Emotional State</PanelHeader>
      <EmotionalStateContainer>
        <EmotionalStateVisualization
          pleasure={emotionalState.pleasure}
          arousal={emotionalState.arousal}
          dominance={emotionalState.dominance}
          size={size}
          showLabels={true}
          showMetrics={size === 'large'}
          historyLength={showHistory ? 20 : 0}
          onInteraction={handleInteraction}
        />
        <EmotionalStateDescription>
          {getEmotionalDescription(emotionalState)}
        </EmotionalStateDescription>
      </EmotionalStateContainer>
    </MetricsPanel>
  );
};
```

## Future Enhancements

### Multi-dimensional Visualization
- 3D visualization of the PAD space
- Interactive navigation of the emotional space
- Emotional trajectory prediction

### Contextual Emotional Responses
- Visualization of emotional triggers from conversation
- Emotional response patterns to specific topics
- Personalized emotional baseline calibration

### Advanced Particle Effects
- GPU-accelerated particle system using WebGL
- More complex particle behaviors and interactions
- Fluid simulation for smoother, more organic movement

### Emotional Music Integration
- Procedurally generated ambient sounds based on emotional state
- Subtle audio cues for emotional transitions
- Harmonic elements tied to pleasure dimension