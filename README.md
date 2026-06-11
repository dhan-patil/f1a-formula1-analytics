# F1A — Formula 1 Race Performance Analysis for macOS

F1A is a Formula 1 race performance analysis platform designed to help users understand why one driver performed better than another by analyzing race factors beyond simple standings and results.

Instead of focusing only on race winners or championship tables, F1A aims to provide deeper performance insights through telemetry comparison, race context analysis, and interactive race review tools.

The platform is designed for Formula 1 enthusiasts who want to better understand race performance, strategy, and decision-making during a Grand Prix.

---

## Project Status

F1A is currently under active development.

The current version focuses on building the frontend experience, race analysis workflows, replay interactions, and telemetry visualization using mock data.

Future versions will integrate real Formula 1 telemetry, backend systems, and historical race datasets to create a more advanced race intelligence experience.

---

## Overview

F1A is built around a simple question:

> Why was one driver faster than another?

Traditional Formula 1 applications usually focus on:

- Standings  
- Race winners  
- Basic statistics  
- Lap times  

F1A focuses on understanding performance factors that influence race outcomes.

The software helps users review and analyze race performance through multiple factors such as:

- Speed  
- Throttle application  
- Braking behaviour  
- Delta time  
- Tyre strategy  
- DRS usage  
- Race gaps  
- Driver comparisons  
- Race context  

The goal is to make Formula 1 performance easier to understand through a clean and analytical desktop experience.

---

## Current Features

### Driver Comparison

Compare two drivers side-by-side to understand performance differences during a race session.

Example comparisons:

- VER vs HAM  
- VER vs PIA  
- NOR vs LEC  

The comparison system dynamically updates race insights and performance metrics.

---

### Race Replay Workspace

Replay and review race moments interactively.

Features include:

- Interactive replay controls  
- Race progression timeline  
- Track position visualization  
- Session review tools  
- Driver movement tracking  

This enables users to revisit key race moments and better understand performance differences.

---

### Performance Analysis Workspace

F1A provides analytical insights across multiple race performance factors.

Metrics currently include:

#### Speed Analysis
Compare speed differences between drivers.

#### Throttle Analysis
Understand throttle application behaviour.

#### Brake Analysis
Compare braking patterns and efficiency.

#### Delta Time Analysis
Review performance gaps between drivers in real time.

Visual comparison graphs are used to make race performance easier to understand.

---

### Race Context Analysis

F1A includes race context information to explain why performance differences occurred.

Contextual factors include:

- Tyre compound  
- Tyre age  
- DRS status  
- Strategy mode  
- Gap between drivers  

This helps explain performance outcomes during different phases of a race.

---

## Tech Stack

### Frontend (Current)

- SwiftUI  
- Swift  
- Xcode  
- Custom reusable UI components  
- Dynamic telemetry visualizations  
- Interactive replay system  

### Planned Backend

The current version uses mock telemetry data while frontend systems are being developed.

Planned technologies include:

- Node.js  
- Express.js  
- Firebase or PostgreSQL  

The backend will support:

- Telemetry storage  
- Historical race data  
- Driver and lap information  
- Race replay sessions  
- Performance processing  

---

## Planned Data Sources & APIs

Future versions aim to integrate real Formula 1 performance data.

Potential data sources include:

- FastF1  
- OpenF1 API  
- Formula 1 telemetry datasets  

This will allow:

- Real telemetry comparisons  
- Accurate race replays  
- Historical session analysis  
- More detailed race insights  

---

## How It Works

F1A is designed as a race performance review and analysis platform.

Users will be able to:

1. Select a Formula 1 race session  
2. Choose two drivers for comparison  
3. Replay race moments interactively  
4. Analyze telemetry and race factors  
5. Review performance differences  
6. Understand how race context influenced outcomes

The objective is not simply to display race data, but to help users understand the reasoning behind race performance.

---

## Future Roadmap

### Phase 1 (Current)
Frontend development, replay system, and mock telemetry

### Phase 2
Real telemetry integration

### Phase 3
Backend implementation

### Phase 4
Historical race database

### Phase 5
Advanced analytical tools

Planned improvements include:

- Sector-by-sector analysis  
- Custom lap comparison  
- Qualifying analysis  
- Strategy comparison tools  
- AI-powered race insights  
- Enhanced performance visualizations  

---

## Vision

F1A aims to become a premium Formula 1 race performance insights platform.

Not simply:

> “Who won?”

But:

> Why did they perform better?

---

## Installation

### Clone the Repository

bash git clone https://github.com/dhan-patil/f1a-formula1-analytics.git 

### Open the Project

1. Open Xcode  
2. Select Open Project  
3. Open the cloned F1A folder  

### Run the Application

1. Select a macOS target or simulator  
2. Press ⌘ + R

The application should build and run successfully.

---

## Developer

Dhan Patil

LinkedIn: https://www.linkedin.com/in/dhanpatil/
