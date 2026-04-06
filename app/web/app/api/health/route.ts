// @req REQ-INFRA-002 Router for API health endpoint
import { NextResponse } from 'next/server';

export async function GET() {
    const apiUrl = process.env.API_URL || 'http://localhost:8080';

    try {
        const res = await fetch(`${apiUrl}/health`);
        const data = await res.json();
        return NextResponse.json(data);
    } catch {
        return NextResponse.json(
            { status: 'error' },
            { status: 503 }
        );
    }
}