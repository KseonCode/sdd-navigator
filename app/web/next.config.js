// @req REQ-INFRA-004 Next.js configuration for Ingress
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  async rewrites() {
    const apiUrl = process.env.API_URL || 'http://localhost:8080';

    return [
      {
        source: '/health',
        destination: `${apiUrl}/health`,
      },
      {
        source: '/health/:path*',
        destination: `${apiUrl}/health/:path*`,
      },
    ];
  },
};

module.exports = nextConfig;
