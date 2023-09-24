import { sql } from '@vercel/postgres';


export const checkTeamWelfare = async ({ expenseTemplateId }: { expenseTemplateId: number }) => {


    const participants = await sql`
        SELECT COUNT(pl.participant_log_id), p.company_id  FROM participant_log_table pl 
        INNER JOIN participant_table p ON pl.participant_id = p.participant_id
        WHERE expense_template_id = ${expenseTemplateId}
        GROUP BY p.company_id
    `
    if (participants.rowCount > 1) {
        return false
    }

    return true
}