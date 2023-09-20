import { error } from '@sveltejs/kit';
import { get } from 'app/lib/api';
import type { RequestEvent } from './$types';

/** @type {import('./$types').RequestHandler} */
export async function GET(request: RequestEvent) {
    const expenseId = request.url.searchParams.get("id")
    const response = await get({ path: `establishment/expense-paid?id=${expenseId}` })

    return new Response(JSON.stringify(response));
}