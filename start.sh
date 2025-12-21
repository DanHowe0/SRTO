#!/usr/bin/env bash
set -e

# Install dependencies
npm install

# Build the server
npm run build

# Start the server
npm start
