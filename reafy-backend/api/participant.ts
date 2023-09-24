import { sql } from '@vercel/postgres';
import type { PostParticipant } from '../types/expenseTypes';
import { createIdentifier } from '../helpers/helperFunctions';

export const config = {
    runtime: 'edge',
};


export default async function participantHandler(
    request: Request,
) {
    if (request.method == "POST") {
        try {
            let body: PostParticipant;
            try {
                body = await request.json();
            } catch (e) {
                body = null;
            }
            console.log(body)
            let company = await sql`
            SELECT row_to_json(company_table) FROM company_table WHERE company_name = (${body?.companyName});
        `

            if (company.rows.length == 0) {
                company = await sql`
                    INSERT INTO company_table (company_name) VALUES (${body?.companyName}) RETURNING row_to_json(company_table);
                `
            }

            const participant_identifier = createIdentifier(body?.participantName!)
            let participant = await sql`
                SELECT row_to_json(participant_table) FROM participant_table WHERE participant_identifier = (${participant_identifier});
            `

            if (participant.rowCount == 0) {
                participant = await sql`
                    INSERT INTO participant_table 
                    (participant_name, participant_identifier, company_id, owner_company_id) 
                    VALUES (${body?.participantName}, ${participant_identifier}, ${company.rows[0]!.row_to_json!.company_id}, ${body?.ownerCompanyId}) 
                    RETURNING row_to_json(participant_table);
                `
            }

            const participant_relation_id = `${company.rows[0]!.row_to_json!.company_id}_${participant.rows[0]!.row_to_json!.participant_id}`
            const participantRelation = await sql`
                INSERT INTO participant_relation_table
                (participant_relation_id, participant_id, relation_owner_company_id, relation)
                SELECT ${participant_relation_id},${participant.rows[0]!.row_to_json!.participant_id},${company.rows[0]!.row_to_json!.company_id},${body?.relation}
                WHERE
                    NOT EXISTS (
                        SELECT participant_relation_id FROM participant_relation_table WHERE participant_relation_id = ${participant_relation_id}
                    )
                RETURNING row_to_json(participant_relation_table)    
                ;
            `
            console.log("works")
            return new Response(
                JSON.stringify({
                    "participantId": participant.rows[0]!.row_to_json!.participant_id,
                    "participantRelationId": participant_relation_id,
                    "participantName": participant.rows[0]!.row_to_json!.participant_name,
                    "company_id": company.rows[0]!.row_to_json!.relation_owner_company_id,
                    "relation": participantRelation.rows[0].row_to_json.relation,
                    "ownerCompanyId": participant.rows[0]!.row_to_json!.owner_company_id
                })
            );
        } catch (e) {
            console.log(e)
            return new Response(JSON.stringify({ "error": e }))
        }
    }

}