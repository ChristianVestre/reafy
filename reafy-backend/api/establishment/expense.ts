import { sql } from '@vercel/postgres';
import { jsonToSql } from '../../utils/jsonToSQL';
import { PostExpense } from '../../types/expenseTypes';
import { getUrlParams } from '../../helpers/helperFunctions';

export const config = {
    runtime: 'edge',
};

export default async function expense(
    request: Request
) {
    if (request.method == "GET") {
        try {
            const params = getUrlParams(request.url)
            console.log(params)
            const expense = await sql`
         SELECT row_to_json(expense_table) FROM expense_table WHERE establishment_id = ${params.id} AND active = true
       `
            console.log(expense)
            const expenseLineItems = await sql`
                SELECT row_to_json(expense_line_item_table)
                FROM expense_line_item_table
                WHERE expense_id = ${expense.rows[0].row_to_json.expense_id};
      `

            const data = {
                totalExpense: expense.rows[0].row_to_json.total_expense,
                expenseId: expense.rows[0].row_to_json.expense_id,
                lineItems: expenseLineItems.rows.map((i) => {
                    return { "name": i.row_to_json.line_item_name, "numberPurchased": i.row_to_json.number_purchased, "costPerItem": i.row_to_json.cost_per_item }
                })
            }

            console.log(expense)
            console.log(expenseLineItems)
            return new Response(
                JSON.stringify(data)
            )
        } catch (e) {
            console.log(e)
            return Response.error()
        }
    }
}