import { sql } from '@vercel/postgres';


export const checkVatExemption = async ({ expenseId, expenseTemplateId }: { expenseId: number, expenseTemplateId: number }) => {
    const expenseData = await sql`
        SELECT row_to_json(expense_table) FROM expense_table WHERE expense_id = ${expenseId};
    `
    const participants = await sql`
        SELECT COUNT(participant_log_id) FROM participant_log_table WHERE expense_template_id = ${expenseTemplateId};
    `
    if (expenseData.rows[0].row_to_json.liquor) {
        return false
    }

    //times 100 since prices are saved in øre
    if (expenseData.rows[0].row_to_json.total_expense / participants.rows[0].count > (551 * 100)) {
        return false
    }

    return true

}