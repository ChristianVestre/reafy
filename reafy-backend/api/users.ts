import { sql } from '@vercel/postgres';
import { PostUsers } from '../types/crudTypes';
import { getUrlParams } from '../helpers/helperFunctions';

export const config = {
    runtime: 'edge',
};

export default async function users(
    request: Request
) {

    if (request.method == "GET") {
        try {
            const params = getUrlParams(request.url)

            const result = await sql`
            SELECT row_to_json(user_table) FROM user_table WHERE company_id = ${params.id};
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
        } catch (e) {
            return new Response(
                JSON.stringify({ "error": e })
            )
        }
    }



    if (request.method == "POST") {
        try {
            let body: PostUsers;
            try {
                body = await request.json();
            } catch (e) {
                body = null;
            }


            return new Response(
                JSON.stringify({})
            );
        } catch (e) {
            return new Response(
                JSON.stringify({ error: e })
            )
        }
    }
}