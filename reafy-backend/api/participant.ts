import { sql } from '@vercel/postgres';
import type { ParticipantRequest } from '../types/expenseTypes';

export const config = {
    runtime: 'edge',
};


export default async function handler(
    request: Request,
) {
    if (request.method == "POST") {
        try {
            let body: ParticipantRequest;
            try {
                body = await request.json();
            } catch (e) {
                body = null;
            }

            let company = await sql`
            SELECT row_to_json(company_table) FROM company_table WHERE company_name = (${body?.companyId});
        `

            if (company.rows.length == 0) {
                company = await sql`
                    INSERT INTO company_table (company_id) VALUES (${body?.companyId}) RETURNING row_to_json(company_table);
                `
            }

            const participant_identifier = body?.participantName.toLocaleLowerCase().split(" ").join("")
            let participant = await sql`
                SELECT row_to_json(participant_table) FROM participant_table WHERE participant_identifier = (${participant_identifier});
            `

            if (participant.rowCount == 0) {
                participant = await sql`
                    INSERT INTO participant_table 
                    (participant_name, participant_identifier, company_id, owner_company_id) 
                    VALUES (${body?.participantName}, ${participant_identifier}, ${company.rows[0]!.row_to_json!.company_id}) 
                    RETURNING row_to_json(participant_table);
                `
            }

            const participant_relation_id = `${company.rows[0]!.row_to_json!.company_id}_${participant.rows[0]!.row_to_json!.participant_id}`
            const participantRelation = await sql`
                INSERT INTO participant_relation_table
                (participant_relation_id, participant_id, company_id, relation)
                SELECT ${participant_relation_id},${participant.rows[0]!.row_to_json!.participant_id},${company.rows[0]!.row_to_json!.company_id},${body?.relation}
                WHERE
                    NOT EXISTS (
                        SELECT participant_relation_id FROM participant_relation_table WHERE participant_relation_id = ${participant_relation_id}
                    )
                RETURNING row_to_json(participant_relation_table)    
                ;
            `

            return new Response(
                JSON.stringify({
                    "participantId": participant.rows[0]!.row_to_json!.participant_id,
                    "participantRelationId": participant_relation_id,
                    "participantName": participant.rows[0]!.row_to_json!.participant_name,
                    "company_id": company.rows[0]!.row_to_json!.company_id,
                    "relation": participantRelation.rows[0].row_to_json.relation,
                    "ownerCompanyId": participant.rows[0]!.row_to_json!.owner_company_id
                })
            );
        } catch (e) {
            return new Response(JSON.stringify({ "error": e }))
        }
    }

}