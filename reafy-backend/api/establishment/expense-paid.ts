import { sql } from '@vercel/postgres';
import { jsonToSql } from '../../utils/jsonToSQL';
import { PostExpense } from '../../types/expenseTypes';
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
            console.log(params)
            const expense = await sql`
                SELECT row_to_json(expense_table) FROM expense_table WHERE expense_id = ${params.id}
            `

            const expenseTransaction = await sql`
                SELECT row_to_json(expense_transaction_table) FROM expense_transaction_table WHERE expense_id = ${params.id}
            `

            const paid = expense.rows[0].row_to_json.active == false && expenseTransaction.rowCount != 0

            if (paid) {
                return new Response(
                    JSON.stringify(paid), { status: 200 }
                )
            }

            return new Response(
                JSON.stringify(paid), { status: 200 }
            )
        } catch (e) {
            console.log(e)
            return Response.error()
        }
    }
}