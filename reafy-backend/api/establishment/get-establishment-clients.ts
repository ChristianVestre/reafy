import { sql } from '@vercel/postgres';
import type { GetEstablishmentClientsRequest } from '../../types/establishmentTypes';

export const config = {
    runtime: 'edge',
};

export default async function handler(
    request: Request,
) {
    let body: GetEstablishmentClientsRequest;
    try {
        body = await request.json();
    } catch (e) {
        body = null;
    }
    try {
        let companies = await sql`
            SELECT json_build_object(
            'companyName',c.company_name,
            'companyId',c.company_id)
            FROM establishment_client_table e
            INNER JOIN company_table c ON e.company_id = c.company_id
            WHERE e.establishment_id = ${body.establishmentId};
        `
        if (companies.rowCount == 0) {
            return new Response(JSON.stringify(
                { "error": "No client companies found" }
            ));
        }
        const data = companies.rows.map((row) => {
            return {
                "companyName": companies.rows[0].json_build_object.companyName,
                "companyId": companies.rows[0].json_build_object.companyId,
            }
        })


        return new Response(JSON.stringify(
            data
        ));
    } catch (e) {
        console.log(e)
        return new Response(JSON.stringify(
            e
        ));
    }

}