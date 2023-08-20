import type { VercelRequest, VercelResponse } from '@vercel/node';
import { sql } from '@vercel/postgres';


export default async function expense(
    request: VercelRequest,
    response: VercelResponse,
) {

    let company = await sql`
    SELECT row_to_json(company_table) FROM company_table WHERE company_name = (${request.body.company_name});
    `

    if (company.rows.length == 0) {
        company = await sql`
      INSERT INTO company_table (company_name) VALUES (${request.body.company_name}) RETURNING row_to_json(company_table);
      `
    }


    const participant = await sql`
      INSERT INTO participant_table
      (participant_name, company_id)
      SELECT ${request.body.name},${company.rows[0]?.row_to_json?.company_id}
      WHERE
          NOT EXISTS (
              SELECT participant_name FROM participant_table WHERE participant_name = ${request.body.name}
          )
      RETURNING row_to_json(participant_table)    
      ;
    `
    const user = await sql`
    INSERT INTO user_table
    (user_name, company_id, company_role, participant_id)
    SELECT ${request.body.name},${company.rows[0]?.row_to_json?.company_id}, ${request.body.company_role}, ${participant.rows[0]?.row_to_json?.participant_id}
    WHERE
        NOT EXISTS (
            SELECT user_name FROM user_table WHERE user_name = ${request.body.name}
        )
    RETURNING row_to_json(user_table)    
    ;
    `


    response.status(200).json({
        body: user,
        query: request.query,
        cookies: request.cookies,
    });
}