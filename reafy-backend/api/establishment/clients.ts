import { sql } from '@vercel/postgres';
import { getUrlParams } from '../../helpers/helperFunctions';

export const config = {
    runtime: 'edge',
};

export default async function clients(
    request: Request,
) {
    if (request.method == "GET") {
        try {
            const params = getUrlParams(request.url)

            let companies = await sql`
                SELECT json_build_object(
                'companyName',c.company_name,
                'companyId',c.company_id)
                FROM establishment_client_table e
                INNER JOIN company_table c ON e.company_id = c.company_id
                WHERE e.establishment_id = ${params.id};
            `

            if (companies.rowCount == 0) {
                return new Response(JSON.stringify(
                    { "error": "No client companies found" }
                ));
            }

            const data = companies.rows.map((row) => {
                return {
                    "companyName": row.json_build_object.companyName,
                    "companyId": row.json_build_object.companyId,
                }
            })
            return new Response(JSON.stringify(
                data
            ));

        } catch (e) {
            console.log(e)
            return Response.error();
        }
    }
}