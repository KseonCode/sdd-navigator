// app/layout.tsx
// @req REQ-INFRA-004 Root layout

import type { Metadata } from 'next';
import './globals.css';

export const metadata: Metadata = {
  title: 'SDD Navigator',
  description: 'Built with Rust and Next.js',
  keywords: 'devops, rust, nextjs, kubernetes',
  authors: [{ name: 'KseonCode' }]
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <head>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
      </head>
      <body>
        {children}
      </body>
    </html>
  );
}