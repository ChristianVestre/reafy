import { sql } from '@vercel/postgres';
import { getUrlParams } from '../../helpers/helperFunctions';
import { PostQueueExpense } from '../../types/establishmentTypes';

export const config = {
    runtime: 'edge',
};

export default async function expense(
    request: Request
) {
    if (request.method == "GET") {
        try {
            const params = getUrlParams(request.url)
            const expense = await sql`
                SELECT row_to_json(expense_table) FROM expense_table WHERE establishment_id = ${params.id} AND active = true
            `
            const expenseLineItems = await sql`
                SELECT row_to_json(expense_line_item_table)
                FROM expense_line_item_table
                WHERE expense_id = ${expense.rows[0].row_to_json.expense_id};
      `

            const data = {
                totalExpense: expense.rows[0].row_to_json.total_expense,
                vat: expense.rows[0].row_to_json.vat,
                expenseId: expense.rows[0].row_to_json.expense_id,
                lineItems: expenseLineItems.rows.map((i) => {
                    return { "name": i.row_to_json.line_item_name, "numberPurchased": i.row_to_json.number_purchased, "costPerItem": i.row_to_json.cost_per_item }
                })
            }

            return new Response(
                JSON.stringify(data)
            )
        } catch (e) {
            console.log(e)
            return Response.error()
        }
    }
    if (request.method == "POST") {
        try {
            let body: PostQueueExpense = await request.json();

            const expense = await sql`
                UPDATE expense_table SET liquor=${body.liquor} WHERE expense_id=${body.expenseId}
            `

            const result = await sql`
                INSERT INTO expense_queue_table (user_id,company_id,establishment_user_id,establishment_id,expense_id,queued) 
                VALUES (${body.userId},${body.companyId},${body.establishmentUserId},${body.establishmentId},${body.expenseId},true)
            `
            return new Response(
                JSON.stringify({ status: 200 })
            )
        } catch (e) {
            console.log(e)
            return Response.error()
        }
    }
}