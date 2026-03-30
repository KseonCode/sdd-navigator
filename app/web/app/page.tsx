// @req REQ-INFRA-002 Frontend consuming API health endpoint
'use client';

import { useEffect, useState } from 'react';

export default function Home() {
  const [status, setStatus] = useState<string>('checking...');

  useEffect(() => {
    fetch('/api/health')
      .then(res => res.json())
      .then(data => setStatus(data.status))
      .catch(() => setStatus('unreachable'));
  }, []);

  return (
    <main>
      <h1>SDD Navigator</h1>
      <p>API Status: {status}</p>
    </main>
  );
}
