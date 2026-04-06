// @req REQ-INFRA-002 Frontend consuming API health endpoint
// app/page.tsx
'use client';

import { useEffect, useState } from 'react';
import './globals.css';

export default function Home() {
  const [status, setStatus] = useState<string>('checking');

  useEffect(() => {
    fetch('/api/health')
      .then(res => res.json())
      .then(data => setStatus(data.status))
      .catch(() => setStatus('unreachable'));
  }, []);

  const getStatusClass = () => {
    if (status === 'ok') return 'ok';
    if (status === 'unreachable') return 'error';
    return 'checking';
  };

  const getStatusText = () => {
    if (status === 'ok') return '✅ Healthy';
    if (status === 'unreachable') return '❌ Unreachable';
    if (status === 'checking') return '⏳ Checking...';
    return status;
  };

  return (
    <div className="container">
      <h1>✨ SDD Navigator</h1>

      <div className="status-card">
        <div className="status-label">API Status</div>
        <div className={`status-value ${getStatusClass()}`}>
          {getStatusText()}
        </div>
      </div>

      <div className="info">
        <div className="tech-stack">
          <span className="tech-badge">☸️ Kubernetes</span>
          <span className="tech-badge">⚙️ Helm</span>
          <span className="tech-badge">📜 Ansible</span>
          <span className="tech-badge">🐘 PostgreSQL</span>
          <span className="tech-badge">🦀 Rust</span>
          <span className="tech-badge">⚛️ Next.js</span>
        </div>

        <div className="copyright">
          © 2026 KseonCode
        </div>
      </div>
    </div>
  );
}
