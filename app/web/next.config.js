// @req REQ-INFRA-004 Next.js configuration for Ingress
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  // Enable standalone output for Docker deployment
}

module.exports = nextConfig
