import { sql } from '@vercel/postgres';
import { User } from '../types/authTypes';
import { createIdentifier } from '../helpers/helperFunctions';

export const config = {
  runtime: 'edge',
};


export default async function handler(
  request: Request,
) {
  let body: User;
  try {
    body = await request.json();
  } catch (e) {
    body = null;
  }
  try {
    const identifier: string = createIdentifier(body.userName)

    let company = await sql`
    SELECT row_to_json(company_table) FROM company_table WHERE company_name = (${body.companyName});
    `

    if (company.rowCount == 0) {
      company = await sql`
      INSERT INTO company_table (company_name) VALUES (${body.companyName}) RETURNING row_to_json(company_table);
      `
    }
    let participant = await sql`
    SELECT row_to_json(participant_table) FROM participant_table WHERE participant_identifier = (${identifier});
    `

    if (participant.rowCount == 0) {
      participant = await sql`
        INSERT INTO participant_table 
        (participant_name, participant_identifier, company_id, owner_company_id) 
        VALUES (${body?.userName}, ${identifier}, ${company.rows[0]!.row_to_json!.company_id}, ${company.rows[0]!.row_to_json!.company_id}) 
        RETURNING row_to_json(participant_table);
        `
    }
    const participantRelationId = `${company.rows[0]!.row_to_json!.company_id}_${participant.rows[0]!.row_to_json!.participant_id}`
    await sql`
      INSERT INTO participant_relation_table
      (participant_relation_id, participant_id, company_id, relation)
      SELECT ${participantRelationId},${participant.rows[0]!.row_to_json!.participant_id},${company.rows[0]!.row_to_json!.company_id},${body?.relation}
      WHERE
          NOT EXISTS (
              SELECT participant_relation_id FROM participant_relation_table WHERE participant_relation_id = ${participantRelationId}
          )
      RETURNING row_to_json(participant_relation_table)    
      ;
    `
    const user = await sql`
    INSERT INTO user_table
    (user_name,user_identifier,user_email, company_id, company_role, participant_id)
    SELECT ${body.userName}, ${identifier}, ${body.email}, ${company.rows[0]?.row_to_json?.company_id}, ${body.companyRole}, ${participant.rows[0]?.row_to_json?.participant_id}
    WHERE
        NOT EXISTS (
            SELECT user_name FROM user_table WHERE user_name = ${body.userName}
        )
    RETURNING row_to_json(user_table)    
    ;
    `
    return new Response(JSON.stringify(
      user
    ));
  } catch (e) {
    new Response(JSON.stringify(
      e
    ));
  }

}