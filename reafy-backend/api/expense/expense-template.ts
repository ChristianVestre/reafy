import { sql } from '@vercel/postgres';
import { PostExpenseTemplate } from '../../types/expenseTypes';
import { jsonToSql } from '../../utils/jsonToSQL';
import { getUrlParams } from '../../helpers/helperFunctions';

export const config = {
    runtime: 'edge',
};

export default async function expensePayed(
    request: Request
) {
    if (request.method == "GET") {
        try {
            const params = getUrlParams(request.url)
            const expenseTemplates = await sql`
                SELECT row_to_json(expense_template_table) FROM expense_template_table WHERE created_by=${params.id} AND active=true;
            `
            const expenseTemplateIds = [expenseTemplates.rows.map((i) => i.row_to_json.expense_template_id)]

            const query = `
                SELECT json_build_object('participantId',p.participant_id,'participantName',p.participant_name,'companyName',c.company_name,'companyId',p.company_id, 'expenseTemplateId',plt.expense_template_id)
                FROM participant_log_table AS plt
                INNER JOIN participant_table AS p ON plt.participant_id = p.participant_id
                INNER JOIN company_table AS c ON p.company_id = c.company_id
                WHERE (expense_template_id) IN (SELECT * FROM UNNEST ($1::int[]));
               `
            const participants = await sql.query(query, expenseTemplateIds)

            let data = expenseTemplates.rows.map((v) => {
                return {
                    "expenseTemplateId": v.row_to_json.expense_template_id,
                    "intent": v.row_to_json.expense_intent,
                    participants: participants.rows
                        .filter((p => p.json_build_object.expenseTemplateId == v.row_to_json.expense_template_id))
                        .map((p) => {
                            return {
                                "participantId": p.json_build_object.participantId,
                                "participantName": p.json_build_object.participantName,
                                "companyId": p.json_build_object.companyId,
                                "companyName": p.json_build_object.companyName
                            }
                        })
                }
            });
            console.log(data)



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
            let body: PostExpenseTemplate = await request.json();
            console.log(body)

            const expense = await sql`
                 INSERT INTO expense_template_table
                 (expense_intent,created_by, active)
                 SELECT ${body!.expenseIntent}, ${body!.createdBy}, true
                 RETURNING row_to_json(expense_template_table)
             `

            //todo make new participant values special for this endpoint : only participantId 
            const participantIds = body.participants.map((i) => i.participantId)
            const participantValues = [participantIds, participantIds.map((i) => expense.rows[0].row_to_json.expense_template_id)]

            // const participantValues = jsonToSql(body!.participants, expense.rows[0].row_to_json.expense_template_id, 1)
            const insertParticipantQuery = "INSERT INTO participant_log_table (participant_id,expense_template_id) SELECT * FROM UNNEST ($1::int[],$2::int[]) RETURNING row_to_json(participant_log_table)"
            const insertParticipantsResult = await sql.query(insertParticipantQuery, participantValues)

            //const insertParticipantsResult = await sql.query(insertParticipantQuery, participantValues)


            const data = {
                active: expense.rows[0].row_to_json.active,
                expenseId: expense.rows[0].row_to_json.expense_id,
                settledBy: expense.rows[0].row_to_json.settledBy
            }

            return new Response(
                JSON.stringify(data)
            )
        } catch (e) {
            console.log(e)
            return Response.error()
        }
    }
}