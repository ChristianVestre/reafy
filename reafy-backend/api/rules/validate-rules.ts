import { sql } from '@vercel/postgres';

export const config = {
    runtime: 'edge',
};

export default async function ValidateRules(
    request: Request,
) {
    const rules = request.body

    const result = await sql`SELECT people_whitelist_table.people_whitelist_id, people_whitelist_table.company_name, people_whitelist_table.participant_id, participant_table.participant_name
    FROM people_whitelist_table
    INNER JOIN participant_table ON people_whitelist_table.participant_id=participant_table.participant_id`


    return Response.json({
        body: result.rows,
    });
}