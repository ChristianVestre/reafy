import { sql } from '@vercel/postgres';
import { Participant } from '../types/crudTypes';

export const config = {
    runtime: 'edge',
};


export default async function handler(
    request: Request,
) {
    let body: Participant;
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

    const participant = await sql`
      INSERT INTO participant_table
      (participant_name, company_id)
      SELECT ${body?.participantName},${company.rows[0]!.row_to_json!.company_id}
      WHERE
          NOT EXISTS (
              SELECT participant_name FROM participant_table WHERE participant_name = ${body?.participantName}
          )
      RETURNING row_to_json(participant_table)    
      ;
    `

    const participantRelation = await sql`
      INSERT INTO participant_relation_table
      (participant_name, company_id, relation)
      SELECT ${body?.participantName},${company.rows[0]!.row_to_json!.company_id}, ${body?.relation}
      WHERE
          NOT EXISTS (
              SELECT participant_name FROM participant_table WHERE participant_name = ${body?.participantName}
          )
      RETURNING row_to_json(participant_table)    
      ;
    `

    console.log(company)

    return new Response(
        JSON.stringify({ participant })
    );
}