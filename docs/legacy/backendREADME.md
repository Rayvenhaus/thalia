# Thalia Neural Visualization Backend

This directory contains the backend components for Thalia's neural visualization interface. These components transform Thalia's internal data structures into formats optimized for the futuristic, Web4.0 visualization interface.

## Overview

The visualization backend extends Thalia's existing API with new endpoints and WebSocket support specifically designed for the neural visualization interface. It provides real-time data about Thalia's memory system, emotional state, conversation flow, and system metrics.

## Components

### Core Modules

- **visualization_api.py**: Defines the API endpoints and WebSocket connection for the visualization interface
- **visualization_integration.py**: Integrates the visualization components with Thalia's existing API
- **integrate_visualization.py**: Main script to add visualization capabilities to Thalia

### Data Transformers

- **memory_visualization.py**: Transforms memory system data for visualization
- **emotional_visualization.py**: Transforms emotional system data for visualization
- **conversation_visualization.py**: Transforms conversation data for visualization
- **system_visualization.py**: Collects and transforms system metrics for visualization

## Integration

The visualization backend integrates with Thalia's existing components:

- **Memory System**: Visualizes the three-tier memory architecture (session, short-term, long-term)
- **Emotional System**: Visualizes the PAD (Pleasure-Arousal-Dominance) emotional model
- **Conversation Flow**: Transforms conversations into a neural network visualization
- **System Metrics**: Provides real-time information about Thalia's operational status

## API Endpoints

The visualization API provides the following endpoints:

- **GET /api/visualization/conversation**: Get conversation data for visualization
- **GET /api/visualization/memory**: Get memory system data for visualization
- **GET /api/visualization/emotional**: Get emotional system data for visualization
- **GET /api/visualization/system**: Get system metrics for visualization
- **GET /api/visualization/full**: Get complete visualization data
- **POST /api/visualization/settings**: Update visualization settings
- **WebSocket /api/visualization/ws**: Real-time visualization updates

## WebSocket Communication

The WebSocket endpoint provides real-time updates for the visualization interface:

- **Initialization**: Sends complete state when a client connects
- **Periodic Updates**: Sends regular updates for dynamic components
- **Client Requests**: Responds to specific update requests from clients
- **Event Notifications**: Broadcasts updates when significant events occur

## Usage

To integrate the visualization backend with Thalia:

1. Make sure Thalia's core components are properly set up
2. Run the integration script:

```bash
python backend/integrate_visualization.py
```

3. Access the API endpoints at `http://<host>:<port>/api/visualization/`
4. Connect to the WebSocket at `ws://<host>:<port>/api/visualization/ws`

## Configuration

The visualization backend uses Thalia's existing configuration system. No additional configuration is required.

## Dependencies

- **FastAPI**: Web framework for API endpoints
- **WebSockets**: For real-time communication
- **psutil**: For system metrics collection
- **Thalia Core Components**: Memory manager, emotional system, prompt flow

## Next Steps

After setting up the backend, you'll need to implement the frontend visualization interface that connects to these endpoints. The frontend should be designed according to the specifications in the design documents.