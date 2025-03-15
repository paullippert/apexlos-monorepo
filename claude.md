# ApexLOS Project Status and Development Guide

## Project Overview

ApexLOS is a mortgage loan origination system with a multi-application architecture built on a monorepo structure. The system is designed to streamline the mortgage application process through intelligent automation, document processing, and decision support.

### Core Applications

The system comprises three main applications:

1. **Borrower Portal** - Customer-facing application for loan applications
2. **Loan Officer Portal** - Specialized tools for loan officers
3. **Operations Portal** - Comprehensive platform for back-office operations

### Repository Structure

The project is split across three GitHub repositories:

1. [apexlos-monorepo](https://github.com/paullippert/apexlos-monorepo) - Main codebase containing all applications and shared libraries
2. [apexlos-infrastructure](https://github.com/paullippert/apexlos-infrastructure) - Infrastructure as Code using Terraform/Pulumi
3. [apexlos-docs](https://github.com/paullippert/apexlos-docs) - Documentation for the system, including the [development checklist](https://github.com/paullippert/apexlos-docs/blob/main/development-checklist.md)

## Current Status

As of March 15, 2025, the following steps have been completed:

1. Created GitHub repositories for the project ✅
2. Set up monorepo structure using Turborepo ✅
3. Configured ESLint, Prettier, and TypeScript ✅
4. Created Next.js applications with proper configurations ✅
5. Set up dependency management with workspace structure ✅
6. Configured development servers with unique ports ✅

## Technology Stack

- **Frontend Framework**: Next.js with App Router
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Monorepo Management**: Turborepo 2.x
- **Package Management**: npm (workspace support)
- **Code Quality**: ESLint, Prettier

## Development Environment Setup

### Prerequisites

- Node.js 18.18 or later
- npm 8.x or later

### Getting Started

1. Clone the repositories:
   ```bash
   git clone https://github.com/paullippert/apexlos-monorepo.git
   git clone https://github.com/paullippert/apexlos-infrastructure.git
   git clone https://github.com/paullippert/apexlos-docs.git
   ```

2. Navigate to the monorepo:
   ```bash
   cd apexlos-monorepo
   ```

3. Run the setup script to install dependencies:
   ```bash
   # For Linux/WSL
   chmod +x setup.sh
   ./setup.sh
   
   # For Windows
   setup.bat
   ```

   This script installs dependencies for:
   - Each individual Next.js application
   - The root workspace

4. Start the development servers:
   ```bash
   npm run dev
   ```

This will start all three applications on different ports:
- Borrower Portal: http://localhost:3000
- Loan Officer Portal: http://localhost:3001
- Operations Portal: http://localhost:3002

## Workspace Configuration

The monorepo is configured as an npm workspace, as defined in package.json:

```json
"workspaces": [
  "apps/*",
  "packages/*"
]
```

This allows sharing dependencies and code between applications.

## Troubleshooting Common Issues

### Workspace Protocol Issue

When creating Next.js applications directly within the workspace, you might encounter an error:
```
npm error code EUNSUPPORTEDPROTOCOL
npm error Unsupported URL Type "workspace:": workspace:*
```

**Solution**: Use the provided setup scripts which:
1. Create applications outside the workspace first, then move them into the apps directory
2. Install dependencies individually for each application
3. Configure application-specific settings

### Turbo Configuration for Version 2.x

If you get an error about "pipeline" vs "tasks", ensure your turbo.json is using the correct format for Turbo 2.x:

```json
{
  "$schema": "https://turbo.build/schema.json",
  "globalDependencies": ["**/.env.*local"],
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": [".next/**", "!.next/cache/**"]
    },
    "lint": {},
    "dev": {
      "cache": false,
      "persistent": true
    },
    "test": {
      "dependsOn": ["build"]
    }
  }
}
```

## Next Steps

According to the [development checklist](https://github.com/paullippert/apexlos-docs/blob/main/development-checklist.md), the next tasks are:

1. Set up CI/CD with GitHub Actions
2. Create development, staging, and production environments
3. Begin infrastructure setup:
   - PostgreSQL database with logical replication
   - ElectricSQL sync service
   - MinIO document storage
   - RabbitMQ message broker
   - Redis cache

## Adding Shadcn UI Components

To add Shadcn UI to each Next.js application:

1. Navigate to each application directory:
   ```bash
   cd apps/borrower-portal
   ```

2. Initialize Shadcn UI:
   ```bash
   npx shadcn-ui@latest init
   ```

3. Add desired components:
   ```bash
   npx shadcn-ui@latest add button card input form
   ```

4. Repeat for each application.

## Building and Testing

- **Build all applications**:
  ```bash
  npm run build
  ```

- **Run tests across all projects**:
  ```bash
  npm run test
  ```

- **Lint all code**:
  ```bash
  npm run lint
  ```

## Documentation

Refer to the [documentation repository](https://github.com/paullippert/apexlos-docs) for comprehensive project documentation, including the development checklist and architectural plans.
