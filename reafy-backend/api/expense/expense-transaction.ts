import { sql } from '@vercel/postgres';
import { PostExpenseTransaction } from '../../types/expenseTypes';

export const config = {
    runtime: 'edge',
};

export default async function expenseTransaction(
    request: Request
) {
    if (request.method == "POST") {
        try {
            let body: PostExpenseTransaction = await request.json();
            console.log(body)
            const expenseTransaction = await sql`
                INSERT INTO expense_transaction_table (settled_by_id, settled_timestamp, expense_id, expense_template_id, company_id, establishment_id) 
                VALUES (${body.settledById}, now()::timestamp,${body.expenseId},${body.expenseTemplateId},${body.companyId},${body.establishmentId});
            `

            const expense = await sql`
                UPDATE expense_table
                SET active=false
                WHERE expense_id = ${body.expenseId};
            `

            await sql`
                UPDATE expense_queue_table
                SET queued=false
                WHERE expense_id = ${body.expenseId};
            `

            return new Response(
                JSON.stringify(expense), { status: 200 }
            )
        } catch (e) {
            console.log(e)
            return Response.error()
        }
    }
}