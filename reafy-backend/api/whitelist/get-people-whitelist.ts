import type { VercelRequest, VercelResponse } from '@vercel/node';
import { sql } from '@vercel/postgres';


export default async function expense(
    request: VercelRequest,
    response: VercelResponse,
  ) {

    const result = await sql`SELECT people_whitelist_table.people_whitelist_id, people_whitelist_table.company_name, people_whitelist_table.participant_id, participant_table.participant_name
    FROM people_whitelist_table
    INNER JOIN participant_table ON people_whitelist_table.participant_id=participant_table.participant_id`
    console.log(result)


    response.status(200).json({
        body: request.body,
        query: request.query,
        cookies: request.cookies,
    });
}