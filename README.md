# ApexLOS Monorepo

## Overview

ApexLOS is a comprehensive mortgage loan origination system with a multi-application architecture built on a monorepo structure. The system streamlines the mortgage application process through intelligent automation, document processing, and decision support.

## Application Structure

The system comprises three main applications:

1. **Borrower Portal** - Customer-facing application for loan applications
2. **Loan Officer Portal** - Specialized tools for loan officers
3. **Operations Portal** - Comprehensive platform for back-office operations

## Technology Stack

- **Frontend Framework**: Next.js with App Router
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Monorepo Management**: Turborepo
- **Package Management**: npm (workspace support)
- **Code Quality**: ESLint, Prettier

## Getting Started

### Prerequisites

- Node.js 18.18 or later
- npm 8.x or later

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/paullippert/apexlos-monorepo.git
   cd apexlos-monorepo
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Run the script to create Next.js applications (if not already created):
   ```bash
   # For Linux/WSL
   chmod +x create-next-apps.sh
   ./create-next-apps.sh
   
   # For Windows
   create-next-apps.bat
   ```

   This script:
   - Creates three Next.js applications (borrower-portal, loan-officer-portal, operations-portal)
   - Configures each with TypeScript, ESLint, Tailwind CSS, App Router, and src directory
   - Sets unique port numbers for each application
   - Moves them into the apps directory for workspace integration

4. Start the development servers:
   ```bash
   npm run dev
   ```

   This will start all three applications on different ports:
   - Borrower Portal: http://localhost:3000
   - Loan Officer Portal: http://localhost:3001
   - Operations Portal: http://localhost:3002

## Workspace Structure

```
apexlos-monorepo/
├── apps/
│   ├── borrower-portal/         # Customer-facing loan application
│   ├── loan-officer-portal/     # Tools for loan officers
│   └── operations-portal/       # Back-office operations platform
├── packages/                    # Shared libraries and components
├── package.json                 # Workspace configuration
└── turbo.json                   # Turborepo configuration
```

## Commands

- **Start development servers for all applications**:
  ```bash
  npm run dev
  ```

- **Build all applications**:
  ```bash
  npm run build
  ```

- **Run linting across all projects**:
  ```bash
  npm run lint
  ```

- **Run tests across all projects**:
  ```bash
  npm run test
  ```

## Contributing

Please refer to the [development checklist](https://github.com/paullippert/apexlos-docs/blob/main/development-checklist.md) for the current status and next steps of the project.

## License

This project is private and confidential.