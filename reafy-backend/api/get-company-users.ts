import { sql } from '@vercel/postgres';

export const config = {
    runtime: 'edge',
};


export default async function handler(
    request: Request,
) {
    let body;
    try {
        body = await request.json();
    } catch (e) {
        body = null;
    }

    const result = await sql`
    SELECT row_to_json(user_table) FROM user_table WHERE company_id = ${body.companyId};
    `

    const data = result.rows.map(row => {
        return {
            "userName": row.row_to_json.user_name,
            "userId": row.row_to_json.user_id,
            "email": row.row_to_json.user_email
        }
    })

    return new Response(
        JSON.stringify(data)
    );
}