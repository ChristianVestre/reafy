import { sql } from '@vercel/postgres';
import type { ParticipantRequest } from '../types/expenseTypes';
import { getUrlParams } from '../helpers/helperFunctions';

export const config = {
    runtime: 'edge',
};


export default async function participants(
    request: Request,
) {
    console.log("its hit")
    console.log(request)
    if (request.method == "GET") {
        try {
            const params = getUrlParams(request.url)
            console.log(params)
            console.log("participants")
            let participants = await sql`
            SELECT  json_build_object('participantName',pt.participant_name,
                'participantId',pt.participant_id,
                'companyName',c.company_name,
                'companyId',c.company_id,
                'relation', pr.relation) FROM participant_table pt INNER JOIN participant_relation_table pr ON pr.participant_id = pt.participant_id
                INNER JOIN company_table c ON pt.company_id = c.company_id
                WHERE pt.owner_company_id = ${params.id};
        `

            console.log(participants)

            const data = participants.rows.map((i) => {

                return { participantName: i.json_build_object.participantName, participantId: i.json_build_object.participantId, companyName: i.json_build_object.companyName, relation: i.json_build_object.relation, companyId: i.json_build_object.companyId }
            })

            return new Response(
                JSON.stringify({
                    data
                })
            );
        } catch (e) {
            console.log(e)
            return new Response(JSON.stringify({ "error": e }))
        }
    }

}