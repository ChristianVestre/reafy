import { sql } from '@vercel/postgres';
import { JSONObject } from '../../types/jsonTypes';
import { MinParticipantsData, ExpenseTemplateData } from "../../types/ruleTypes"


export const checkMinParticipants = async ({ expenseTemplateId, ruleData }: { expenseTemplateId: number, ruleData: JSONObject }) => {
    const minParticipantsData = ruleData as MinParticipantsData
    const participants = await sql`
        SELECT COUNT(participant_log_id) FROM participant_log_table WHERE expense_template_id = ${expenseTemplateId};
    `

    if (minParticipantsData.minParticipants > participants.rows[0].count) {
        console.log("test")
        return false
    }

    return true

}